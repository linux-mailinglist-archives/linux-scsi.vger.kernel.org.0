Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53E0340D0C
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Mar 2021 19:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhCRSde (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 18 Mar 2021 14:33:34 -0400
Received: from mail-1.ca.inter.net ([208.85.220.69]:59633 "EHLO
        mail-1.ca.inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCRSct (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 18 Mar 2021 14:32:49 -0400
Received: from localhost (offload-3.ca.inter.net [208.85.220.70])
        by mail-1.ca.inter.net (Postfix) with ESMTP id 79C972EA031;
        Thu, 18 Mar 2021 14:32:46 -0400 (EDT)
Received: from mail-1.ca.inter.net ([208.85.220.69])
        by localhost (offload-3.ca.inter.net [208.85.220.70]) (amavisd-new, port 10024)
        with ESMTP id 2CFbnCCDfWEB; Thu, 18 Mar 2021 14:15:13 -0400 (EDT)
Received: from [192.168.48.23] (host-45-58-219-4.dyn.295.ca [45.58.219.4])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail-1.ca.inter.net (Postfix) with ESMTPSA id 5A8A82EA27A;
        Thu, 18 Mar 2021 14:32:43 -0400 (EDT)
Reply-To: dgilbert@interlog.com
Subject: Re: [Bug 212337] scsi_debug: race at module load and module unload
To:     bugzilla-daemon@bugzilla.kernel.org, linux-scsi@vger.kernel.org
References: <bug-212337-11613@https.bugzilla.kernel.org/>
 <bug-212337-11613-BobYNlW3hA@https.bugzilla.kernel.org/>
From:   Douglas Gilbert <dgilbert@interlog.com>
Cc:     Hannes Reinecke <hare@suse.de>
Message-ID: <9e060bf1-c676-217d-0608-141b96335676@interlog.com>
Date:   Thu, 18 Mar 2021 14:32:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bug-212337-11613-BobYNlW3hA@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2021-03-18 1:38 p.m., bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=212337
> 
> Luis Chamberlain (mcgrof@kernel.org) changed:
> 
>             What    |Removed                     |Added
> ----------------------------------------------------------------------------
>               Status|NEW                         |RESOLVED
>           Resolution|---                         |WILL_NOT_FIX
> 
> --- Comment #1 from Luis Chamberlain (mcgrof@kernel.org) ---
> 
> At first glance this might seem like a problem with scsi's async probe, and so
> one might believe disabling CONFIG_SCSI_SCAN_ASYNC could help, however it does
> not. Linux scsi doesn't have semantics to allow only one driver to prefer to
> probe asynchronously, but we can shoe-horn this in as follows:
> 
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index 3cdeaeb92933..d970050ae866 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -857,6 +857,8 @@ static const int device_qfull_result =
> 
>   static const int condition_met_result = SAM_STAT_CONDITION_MET;
> 
> +MODULE_IMPORT_NS(SCSI_PRIVATE);
> +int scsi_complete_async_scans(void);
> 
>   /* Only do the extra work involved in logical block provisioning if one or
>    * more of the lbpu, lbpws or lbpws10 parameters are given and we are doing
> @@ -6851,6 +6853,7 @@ static int __init scsi_debug_init(void)
>                          }
>                  }
>          }
> +       scsi_complete_async_scans();
>          if (sdebug_verbose)
>                  pr_info("built %d host(s)\n", sdebug_num_hosts);
> 
> Even with this present though we still have he refcnt issue. A better way to
> see what is going on is to trace the kernel module calls after boot and see why
> perhaps certain refcounts for the module are high at times and why they are not
> in most other cases.

Hi,
Interesting analysis. There have been many changes to the scsi_debug driver
during the last 6 months, but none that I can remember in module
initialization area. Do you think this is a problem introduced by those
changes or may it have been there for a longer period? Could it be that
the scsi_debug driver is exposing the async nature of the scanning code.
Of course, commencing device teardown during an async scan is stress testing
that code. It would be an improvement IMO, if rmmod alerted the module
in question when it rejects a removal attempt with "device busy".

To stop any higher levels setting up SCSI devices before the async scans
are complete, the scsi_debug can set TEST UNIT READY to return an error
along the lines of: not ready, device in process of becoming ready
BTW that is what real devices do, but scsi_debug does not do that by default.

The scsi_debug module option that is already in place is:
   tur_ms_to_ready: TEST UNIT READY millisecs before initial good status (def=0)

So it's just a fixed delay at the moment. Perhaps you could experiment with that
option to see if it improves things.

The post is cc-ed to Hannes Reinecke who does most of the work in the async
scanning area.

Doug Gilbert


> Enable module tracing
> 
> # for i in $(sudo find /sys/kernel/debug/tracing/events/module/ -name
> "enable"); do echo 1 > $i; done
> 
> Run a loop to test modprobe / rmmod, and fail if either fails. In this case
> let's assume a success of rmmod once and then a failure on the second removal.
> We get the following ftrace, I'll provide some comments in areas where this may
> be useful
> 
> # cat trace /sys/kernel/tracing
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 355/355   #P:8
> #
> #                                _-----=> irqs-off
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| /     delay
> #           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
> #              | |         |   ||||      |         |
>          modprobe-902     [005] ....    45.731217: module_get: scsi_mod
> call_site=resolve_symbol refcnt=6
>          modprobe-902     [005] ....    45.732844: module_load: scsi_debug E
>          modprobe-902     [005] ....    45.732850: module_get: scsi_debug
> call_site=sdebug_add_store [scsi_debug] refcnt=3
>          modprobe-902     [005] ....    45.733589: module_put: scsi_debug
> call_site=sdebug_add_store [scsi_debug] refcnt=2
>          modprobe-902     [005] ....    45.733963: module_get: scsi_debug
> call_site=sdebug_driver_probe [scsi_debug] refcnt=3
>          modprobe-902     [001] ....    45.738246: module_put: scsi_debug
> call_site=sdebug_driver_probe [scsi_debug] refcnt=2
>     kworker/u16:3-173     [002] ....    45.738790: module_get: scsi_debug
> call_site=scsi_debug_slave_alloc [scsi_debug] refcnt=3
>     kworker/u16:3-173     [002] ....    45.739943: module_put: scsi_debug
> call_site=scsi_debug_slave_alloc [scsi_debug] refcnt=2
>     kworker/u16:3-173     [007] ....    45.748555: module_get: scsi_debug
> call_site=scsi_debug_slave_configure [scsi_debug] refcnt=3
>     kworker/u16:3-173     [007] .N..    45.749962: module_put: scsi_debug
> call_site=scsi_debug_slave_configure [scsi_debug] refcnt=2
>     kworker/u16:3-173     [000] d...    45.766235: module_get: scsi_debug
> call_site=scsi_device_get [scsi_mod] refcnt=3
>     kworker/u16:3-173     [000] d...    45.769197: module_get: scsi_debug
> call_site=scsi_device_get [scsi_mod] refcnt=4
>     kworker/u16:3-173     [000] ....    45.769197: module_put: scsi_debug
> call_site=scsi_device_put [scsi_mod] refcnt=3
>     kworker/u16:3-173     [000] ....    45.769198: module_put: scsi_debug
> call_site=scsi_device_put [scsi_mod] refcnt=2
>     kworker/u16:3-173     [000] d...    45.769199: module_get: scsi_debug
> call_site=scsi_device_get [scsi_mod] refcnt=3
>     kworker/u16:3-173     [000] ....    45.769785: module_put: scsi_debug
> call_site=__scsi_iterate_devices [scsi_mod] refcnt=2
>          modprobe-902     [001] ....    45.773492: module_put: scsi_debug
> call_site=do_init_module refcnt=1
> 
> So we can escape initialization early in one case as sg module is not yet
> available.
> 
>     systemd-udevd-907     [001] ....    45.773818: module_get: scsi_mod
> call_site=resolve_symbol refcnt=7
>     systemd-udevd-907     [001] ....    45.774708: module_load: sg E
>     systemd-udevd-907     [001] ....    45.776173: module_put: sg
> call_site=do_init_module refcnt=1
>     systemd-udevd-907     [001] ....    45.778501: module_get: scsi_mod
> call_site=resolve_symbol refcnt=8
>     systemd-udevd-907     [001] ....    45.778569: module_get: t10_pi
> call_site=resolve_symbol refcnt=3
>     systemd-udevd-907     [001] ....    45.779733: module_load: sd_mod E
>     systemd-udevd-907     [001] ....    45.828660: module_put: sd_mod
> call_site=do_init_module refcnt=1
>             rmmod-908     [003] ....    45.921238: module_free: scsi_debug
> 
> We remove the scsi_debug module here fine before systemd-udevd has opened the
> device.
> 
>             rmmod-908     [003] ....    45.921442: module_put: scsi_mod
> call_site=module_unload_free refcnt=7
>          modprobe-914     [006] ....    45.944276: module_get: scsi_mod
> call_site=resolve_symbol refcnt=8
> 
>          modprobe-914     [006] ....    45.945820: module_load: scsi_debug E
>          modprobe-914     [006] ....    45.945825: module_get: scsi_debug
> call_site=sdebug_add_store [scsi_debug] refcnt=3
>          modprobe-914     [006] ....    45.946553: module_put: scsi_debug
> call_site=sdebug_add_store [scsi_debug] refcnt=2
>          modprobe-914     [006] ....    45.947044: module_get: scsi_debug
> call_site=sdebug_driver_probe [scsi_debug] refcnt=3
>          modprobe-914     [006] ....    45.952509: module_put: scsi_debug
> call_site=sdebug_driver_probe [scsi_debug] refcnt=2
>     kworker/u16:3-173     [006] ....    45.953257: module_get: scsi_debug
> call_site=scsi_debug_slave_alloc [scsi_debug] refcnt=3
>     kworker/u16:3-173     [006] .N..    45.954616: module_put: scsi_debug
> call_site=scsi_debug_slave_alloc [scsi_debug] refcnt=2
>     kworker/u16:3-173     [006] ....    45.964402: module_get: scsi_debug
> call_site=scsi_debug_slave_configure [scsi_debug] refcnt=3
>     kworker/u16:3-173     [006] .N..    45.965695: module_put: scsi_debug
> call_site=scsi_debug_slave_configure [scsi_debug] refcnt=2
>     kworker/u16:3-173     [005] d...    46.213491: module_get: scsi_debug
> call_site=scsi_device_get [scsi_mod] refcnt=3
>     kworker/u16:3-173     [005] d...    46.215346: module_get: scsi_debug
> call_site=scsi_device_get [scsi_mod] refcnt=4
>     kworker/u16:3-173     [005] ....    46.215347: module_put: scsi_debug
> call_site=scsi_device_put [scsi_mod] refcnt=3
>     kworker/u16:3-173     [005] ....    46.215348: module_put: scsi_debug
> call_site=scsi_device_put [scsi_mod] refcnt=2
>     kworker/u16:3-173     [005] d...    46.215350: module_get: scsi_debug
> call_site=scsi_device_get [scsi_mod] refcnt=3
>     kworker/u16:3-173     [005] ....    46.220794: module_put: scsi_debug
> call_site=__scsi_iterate_devices [scsi_mod] refcnt=2
>     kworker/u16:4-174     [004] ....    46.224892: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=3
>     kworker/u16:4-174     [004] ....    46.224893: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     kworker/u16:4-174     [004] ....    46.224894: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=3
>            <idle>-0       [004] d.h.    46.228906: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=4
>            <idle>-0       [004] d.h.    46.228907: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>            <idle>-0       [004] d.h.    46.228907: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=2
>     kworker/u16:4-174     [004] ....    46.230926: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=3
>     kworker/u16:4-174     [004] ....    46.230926: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     kworker/u16:4-174     [004] ....    46.230927: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=3
>            <idle>-0       [004] d.h.    46.234937: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=4
>            <idle>-0       [004] d.h.    46.234938: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>            <idle>-0       [004] d.h.    46.234938: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=2
>     kworker/u16:4-174     [004] .N..    46.246062: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=3
>     kworker/u16:4-174     [004] .N..    46.246064: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     kworker/u16:4-174     [004] .N..    46.246065: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=3
>            <idle>-0       [004] d.h.    46.250071: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=4
>            <idle>-0       [004] d.h.    46.250072: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>            <idle>-0       [004] d.h.    46.250072: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=2
>     kworker/u16:4-174     [004] ....    46.252943: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=3
>     kworker/u16:4-174     [004] ....    46.252943: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     kworker/u16:4-174     [004] ....    46.252944: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=3
>            <idle>-0       [004] d.h.    46.256956: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=4
>            <idle>-0       [004] d.h.    46.256957: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>            <idle>-0       [004] d.h.    46.256957: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=2
>     kworker/u16:4-174     [004] ....    46.258547: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=3
>     kworker/u16:4-174     [004] ....    46.258547: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     kworker/u16:4-174     [004] ....    46.258548: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=3
>            <idle>-0       [004] d.h.    46.262558: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=4
>            <idle>-0       [004] d.h.    46.262558: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>            <idle>-0       [004] d.h.    46.262559: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=2
>     kworker/u16:4-174     [004] .N..    46.266484: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=3
>     kworker/u16:4-174     [004] .N..    46.266484: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     kworker/u16:4-174     [004] .N..    46.266485: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=3
>            <idle>-0       [004] d.h.    46.270492: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=4
>            <idle>-0       [004] d.h.    46.270492: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>            <idle>-0       [004] d.h.    46.270493: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=2
>     kworker/u16:4-174     [004] ....    46.272381: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=3
>     kworker/u16:4-174     [004] ....    46.272382: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     kworker/u16:4-174     [004] ....    46.272382: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=3
>            <idle>-0       [004] d.h.    46.276393: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=4
>            <idle>-0       [004] d.h.    46.276393: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>            <idle>-0       [004] d.h.    46.276394: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=2
>     kworker/u16:4-174     [004] ....    46.278258: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=3
>     kworker/u16:4-174     [004] ....    46.278259: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     kworker/u16:4-174     [004] ....    46.278259: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=3
>            <idle>-0       [004] d.h.    46.282269: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=4
>            <idle>-0       [004] d.h.    46.282270: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>            <idle>-0       [004] d.h.    46.282270: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=2
>     kworker/u16:4-174     [004] ....    46.374616: module_get: sd_mod
> call_site=blkdev_get_no_open refcnt=2
>     kworker/u16:4-174     [004] ....    46.374617: module_get: scsi_debug
> call_site=scsi_device_get [scsi_mod] refcnt=3
>      kworker/4:1H-189     [004] ....    46.376457: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>      kworker/4:1H-189     [004] ....    46.376457: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>      kworker/4:1H-189     [004] ....    46.376458: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>       kworker/4:1-62      [004] d.h.    46.380469: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>       kworker/4:1-62      [004] d.h.    46.380470: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>       kworker/4:1-62      [004] d.h.    46.380470: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>      kworker/0:1H-89      [000] ....    46.383278: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>      kworker/0:1H-89      [000] ....    46.383279: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>      kworker/0:1H-89      [000] ....    46.383280: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [000] d.h.    46.387291: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [000] d.h.    46.387292: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [000] d.h.    46.387292: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>      kworker/0:1H-89      [000] ....    46.389080: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>      kworker/0:1H-89      [000] ....    46.389081: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>      kworker/0:1H-89      [000] ....    46.389081: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [000] d.h.    46.393090: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [000] d.h.    46.393091: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [000] d.h.    46.393091: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     kworker/u16:4-174     [000] ....    46.393170: module_put: scsi_debug
> call_site=scsi_device_put [scsi_mod] refcnt=2
>     kworker/u16:4-174     [000] ....    46.393171: module_put: sd_mod
> call_site=blkdev_put refcnt=1
>     systemd-udevd-907     [003] ....    46.393476: module_get: sd_mod
> call_site=blkdev_get_no_open refcnt=2
>     systemd-udevd-907     [003] ....    46.393477: module_get: scsi_debug
> call_site=scsi_device_get [scsi_mod] refcnt=3
>     kworker/u16:4-174     [000] ....    46.395771: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     kworker/u16:4-174     [000] ....    46.395772: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     kworker/u16:4-174     [000] ....    46.395773: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [000] d.h.    46.399789: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [000] d.h.    46.399790: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [000] d.h.    46.399790: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     kworker/u16:4-174     [000] ....    46.402067: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     kworker/u16:4-174     [000] ....    46.402068: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     kworker/u16:4-174     [000] ....    46.402069: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [000] d.h.    46.406078: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [000] d.h.    46.406079: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [000] d.h.    46.406079: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>         multipath-926     [005] ....    46.409545: module_get: sd_mod
> call_site=blkdev_get_no_open refcnt=3
>         multipath-926     [005] ....    46.409547: module_get: scsi_debug
> call_site=scsi_device_get [scsi_mod] refcnt=4
>         multipath-926     [005] ....    46.409649: module_get: dm_mod
> call_site=misc_open refcnt=2
>         multipath-926     [005] ....    46.409773: module_put: dm_mod
> call_site=__fput refcnt=1
>         multipath-926     [005] ....    46.410096: module_put: scsi_debug
> call_site=scsi_device_put [scsi_mod] refcnt=3
>         multipath-926     [005] ....    46.410097: module_put: sd_mod
> call_site=blkdev_put refcnt=2
>     systemd-udevd-907     [003] ....    46.410279: module_get: sd_mod
> call_site=blkdev_get_no_open refcnt=3
>     systemd-udevd-907     [003] ....    46.410280: module_get: scsi_debug
> call_site=scsi_device_get [scsi_mod] refcnt=4
>     systemd-udevd-907     [003] ....    46.413760: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.413760: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=6
>     systemd-udevd-907     [003] ....    46.413760: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.417764: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=6
>            <idle>-0       [003] d.h.    46.417764: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.417764: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>     kworker/u16:4-174     [000] ....    46.438981: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     kworker/u16:4-174     [000] ....    46.438981: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=6
>     kworker/u16:4-174     [000] ....    46.438982: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.439875: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=6
>     systemd-udevd-907     [003] ....    46.439875: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=7
>     systemd-udevd-907     [003] ....    46.439876: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=6
>            <idle>-0       [000] d.h.    46.442992: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=7
>            <idle>-0       [000] d.h.    46.442993: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=6
>            <idle>-0       [000] d.h.    46.442994: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.443880: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=6
>            <idle>-0       [003] d.h.    46.443880: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.443880: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>     kworker/u16:4-174     [000] ....    46.444546: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     kworker/u16:4-174     [000] ....    46.444547: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=6
>     kworker/u16:4-174     [000] ....    46.444548: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.445450: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=6
>     systemd-udevd-907     [003] ....    46.445450: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=7
>     systemd-udevd-907     [003] ....    46.445450: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=6
>            <idle>-0       [000] d.h.    46.448558: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=7
>            <idle>-0       [000] d.h.    46.448559: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=6
>            <idle>-0       [000] d.h.    46.448559: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.449452: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=6
>            <idle>-0       [003] d.h.    46.449453: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.449453: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>     kworker/u16:4-174     [000] ....    46.450135: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     kworker/u16:4-174     [000] ....    46.450136: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=6
>     kworker/u16:4-174     [000] ....    46.450136: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.451003: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=6
>     systemd-udevd-907     [003] ....    46.451003: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=7
>     systemd-udevd-907     [003] ....    46.451004: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=6
>            <idle>-0       [000] d.h.    46.454147: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=7
>            <idle>-0       [000] d.h.    46.454148: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=6
>            <idle>-0       [000] d.h.    46.454148: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.455008: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=6
>            <idle>-0       [003] d.h.    46.455008: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.455008: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>     kworker/u16:4-174     [000] ....    46.455910: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     kworker/u16:4-174     [000] ....    46.455910: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=6
>     kworker/u16:4-174     [000] ....    46.455911: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.456804: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=6
>     systemd-udevd-907     [003] ....    46.456805: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=7
>     systemd-udevd-907     [003] ....    46.456805: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=6
>            <idle>-0       [000] d.h.    46.459920: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=7
>            <idle>-0       [000] d.h.    46.459921: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=6
>            <idle>-0       [000] d.h.    46.459921: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.460808: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=6
>            <idle>-0       [003] d.h.    46.460809: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.460809: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>     kworker/u16:4-174     [000] ....    46.461664: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     kworker/u16:4-174     [000] ....    46.461664: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=6
>     kworker/u16:4-174     [000] ....    46.461665: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.462544: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=6
>     systemd-udevd-907     [003] ....    46.462545: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=7
>     systemd-udevd-907     [003] ....    46.462545: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=6
>            <idle>-0       [000] d.h.    46.465674: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=7
>            <idle>-0       [000] d.h.    46.465675: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=6
>            <idle>-0       [000] d.h.    46.465675: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.466547: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=6
>            <idle>-0       [003] d.h.    46.466548: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.466548: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>     kworker/u16:4-174     [000] ....    46.467413: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     kworker/u16:4-174     [000] ....    46.467413: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=6
>     kworker/u16:4-174     [000] ....    46.467414: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.468319: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=6
>     systemd-udevd-907     [003] ....    46.468319: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=7
>     systemd-udevd-907     [003] ....    46.468319: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=6
>            <idle>-0       [000] d.h.    46.471425: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=7
>            <idle>-0       [000] d.h.    46.471426: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=6
>            <idle>-0       [000] d.h.    46.471426: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.472322: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=6
>            <idle>-0       [003] d.h.    46.472323: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.472323: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>     systemd-udevd-907     [003] ....    46.473538: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.473538: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=6
>     systemd-udevd-907     [003] ....    46.473538: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>          modprobe-914     [006] ....    46.474870: module_put: scsi_debug
> call_site=do_init_module refcnt=4
> 
>            <idle>-0       [003] d.h.    46.477540: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.477541: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.477541: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     systemd-udevd-907     [003] ....    46.478789: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     systemd-udevd-907     [003] ....    46.478789: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.478790: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.482795: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.482796: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.482796: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     systemd-udevd-907     [003] ....    46.483713: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     systemd-udevd-907     [003] ....    46.483713: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.483714: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.487723: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.487723: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.487724: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     systemd-udevd-907     [003] ....    46.488736: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     systemd-udevd-907     [003] ....    46.488737: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.488737: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.492740: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.492741: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.492741: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     systemd-udevd-907     [003] ....    46.493621: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     systemd-udevd-907     [003] ....    46.493621: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.493621: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.497627: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.497628: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.497628: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     systemd-udevd-907     [003] ....    46.498631: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     systemd-udevd-907     [003] ....    46.498632: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.498632: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.502634: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.502635: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.502635: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     systemd-udevd-907     [003] ....    46.503506: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     systemd-udevd-907     [003] ....    46.503507: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.503507: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.507513: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.507513: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.507514: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     systemd-udevd-907     [003] ....    46.508540: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     systemd-udevd-907     [003] ....    46.508540: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.508541: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.512543: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.512543: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.512543: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     systemd-udevd-907     [003] ....    46.513421: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     systemd-udevd-907     [003] ....    46.513421: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.513421: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.517425: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.517425: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.517425: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     systemd-udevd-907     [003] ....    46.518504: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     systemd-udevd-907     [003] ....    46.518505: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.518505: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.522509: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.522509: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.522509: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     systemd-udevd-907     [003] ....    46.523418: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     systemd-udevd-907     [003] ....    46.523418: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.523418: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.527420: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.527420: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.527420: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     systemd-udevd-907     [003] ....    46.528436: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     systemd-udevd-907     [003] ....    46.528437: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.528437: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.532440: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.532441: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.532441: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     systemd-udevd-907     [003] ....    46.533324: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     systemd-udevd-907     [003] ....    46.533324: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.533324: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.537329: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.537330: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.537330: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     systemd-udevd-907     [003] ....    46.538373: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     systemd-udevd-907     [003] ....    46.538374: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.538374: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.542376: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.542377: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.542377: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     systemd-udevd-907     [003] ....    46.543259: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     systemd-udevd-907     [003] ....    46.543260: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.543260: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.547268: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.547269: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.547269: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     systemd-udevd-907     [003] ....    46.548246: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     systemd-udevd-907     [003] ....    46.548246: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.548247: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.552251: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.552251: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.552251: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     systemd-udevd-907     [003] ....    46.553258: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     systemd-udevd-907     [003] ....    46.553258: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.553258: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.557264: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.557264: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.557264: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     systemd-udevd-907     [003] ....    46.558294: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     systemd-udevd-907     [003] ....    46.558295: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.558295: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.562299: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.562300: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.562300: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     systemd-udevd-907     [003] ....    46.563242: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     systemd-udevd-907     [003] ....    46.563242: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.563242: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.567248: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.567248: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.567249: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     systemd-udevd-907     [003] ....    46.568196: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     systemd-udevd-907     [003] ....    46.568196: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.568197: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.572204: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.572205: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.572205: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     systemd-udevd-907     [003] ....    46.573125: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     systemd-udevd-907     [003] ....    46.573125: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.573126: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.577132: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.577133: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.577133: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     systemd-udevd-907     [003] ....    46.578070: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     systemd-udevd-907     [003] ....    46.578071: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.578071: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.582079: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.582080: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.582080: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     systemd-udevd-907     [003] ....    46.583013: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>     systemd-udevd-907     [003] ....    46.583013: module_get: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=5
>     systemd-udevd-907     [003] ....    46.583014: module_put: scsi_debug
> call_site=schedule_resp [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.587025: module_get: scsi_debug
> call_site=sdebug_q_cmd_complete [scsi_debug] refcnt=5
>            <idle>-0       [003] d.h.    46.587026: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=4
>            <idle>-0       [003] d.h.    46.587026: module_put: scsi_debug
> call_site=sdebug_q_cmd_hrt_complete [scsi_debug] refcnt=3
>     systemd-udevd-907     [003] ....    46.587080: module_put: scsi_debug
> call_site=scsi_device_put [scsi_mod] refcnt=2
>     systemd-udevd-907     [003] ....    46.587081: module_put: sd_mod
> call_site=blkdev_put refcnt=2
>     systemd-udevd-907     [003] ....    46.588154: module_put: scsi_debug
> call_site=scsi_device_put [scsi_mod] refcnt=1
>     systemd-udevd-907     [003] ....    46.588155: module_put: sd_mod
> call_site=blkdev_put refcnt=1
> 
> One might be at first motivated to implment sledge hammers as follows:
> 
> static void sdebug_wait_empty_num_in_q(void)
> {
>          struct sdebug_host_info *sdbg_host;
>          struct Scsi_Host *shost;
>          struct scsi_device *sdev;
>          struct sdebug_dev_info *devip;
>          int count, max_wait = 5, k;
>          bool busy;
> 
>          while (true) {
>                  busy = false;
>                  spin_lock(&sdebug_host_list_lock);
>                  list_for_each_entry(sdbg_host, &sdebug_host_list, host_list) {
>                          shost = sdbg_host->shost;
>                          shost_for_each_device(sdev, shost) {
>                                  devip = (struct sdebug_dev_info
> *)sdev->hostdata;
>                                  if (atomic_read(&devip->num_in_q) != 0)
>                                          busy = true;
>                                  k = find_first_bit(devip->uas_bm,
> SDEBUG_NUM_UAS);
>                                  if (k != SDEBUG_NUM_UAS)
>                                          busy = true;
>                          }
>                  }
>                  spin_unlock(&sdebug_host_list_lock);
>                  if (!busy || count >= max_wait) {
>                          break;
>                  }
>                  ssleep(1);
>                  count++;
>          }
> }
> 
> /* Waits for all pending commands to complete. */
> static void wait_all_queued(void)
> {
>          int j, k;
>          struct sdebug_queue *sqp;
>          bool busy;
> 
>          while (true) {
>                  busy = false;
>                  for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp)
> {
>                          k = find_first_bit(sqp->in_use_bm, sdebug_max_queue);
>                          if (k != sdebug_max_queue)
>                                  busy = true;
>                  }
>                  if (!busy)
>                          break;
>                  ssleep(1);
>          }
> }
> 
> static void sync_qc_helper(struct sdebug_defer *sd_dp,
>                             enum sdeb_defer_type defer_t)
> {
>          if (!sd_dp)
>                  return;
>          if (defer_t == SDEB_DEFER_HRT) {
>                  hrtimer_forward_now(&sd_dp->hrt, 2 *
> hrtimer_get_remaining(&sd_dp->hrt));
>          } else if (defer_t == SDEB_DEFER_WQ) {
>                  flush_work(&sd_dp->ew.work);
>          }
> }
> 
> static void scsi_debug_sync_queued_cmnd(void)
> {
>          unsigned long iflags;
>          int j, k, qmax, r_qmax;
>          enum sdeb_defer_type l_defer_t;
>          struct sdebug_queue *sqp;
>          struct sdebug_queued_cmd *sqcp;
>          struct sdebug_defer *sd_dp;
> 
>          for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp) {
>                  spin_lock_irqsave(&sqp->qc_lock, iflags);
>                  qmax = sdebug_max_queue;
>                  r_qmax = atomic_read(&retired_max_queue);
>                  if (r_qmax > qmax)
>                          qmax = r_qmax;
>                  for (k = 0; k < qmax; ++k) {
>                          if (test_bit(k, sqp->in_use_bm)) {
>                                  sqcp = &sqp->qc_arr[k];
>                                  sd_dp = sqcp->sd_dp;
>                                  if (sd_dp)
>                                          l_defer_t = sd_dp->defer_t;
>                                  else
>                                          l_defer_t = SDEB_DEFER_NONE;
>                                  spin_unlock_irqrestore(&sqp->qc_lock, iflags);
>                                  sync_qc_helper(sd_dp, l_defer_t);
>                                  spin_lock_irqsave(&sqp->qc_lock, iflags);
>                          }
>                  }
>                  spin_unlock_irqrestore(&sqp->qc_lock, iflags);
>          }
> }
> 
> static void wait_for_ready(void)
> {
>          struct scsi_sense_hdr sense_hdr;
>          struct sdebug_host_info *sdbg_host;
>          struct Scsi_Host *shost;
>          struct scsi_device *sdev;
>          int ret;
>          bool all_ready;
> 
>          spin_lock(&sdebug_host_list_lock);
>          while (true) {
>                  all_ready = true;
>                  list_for_each_entry(sdbg_host, &sdebug_host_list, host_list) {
>                          shost = sdbg_host->shost;
>                          shost_for_each_device(sdev, shost) {
>                                  ret = scsi_internal_device_block_nowait(sdev);
>                                  if (ret)
>                                          all_ready = false;
>                                  ret = scsi_internal_device_unblock_nowait(sdev,
> SDEV_RUNNING);
>                                  if (ret)
>                                          all_ready = false;
>                                  ret = scsi_test_unit_ready(sdev, 5 * HZ, 100,
> &sense_hdr);
>                                  if (ret != 0)
>                                          all_ready = false;
>                          }
>                  }
>                  if (all_ready)
>                          break;
>                  ssleep(1);
>          }
>          spin_unlock(&sdebug_host_list_lock);
> }
> 
> And use these on scsi_debug_init() but that does not suffice, and the reason is
> that userspace can open the scsi devices after initialization, namely in this
> case we see evidence of userspace processes such as systemd-udevd and multipath
> which will try to open the device.
> 
> There are a few solutions possible, using sync, or sg_sync is not one of them
> as we have to ensure we have no userspace application accessing the devices
> still.
> 
> You can use lsof for this purpose. Below is an example script which can be
> used.
> 
> #!/bin/bash
> 
> LOOP=1
> 
> while true; do
>          modprobe scsi_debug
>          if [[ $? -ne 0 ]]; then
>                  echo "scsi_debug modprobe failed at count $LOOP"
>                  exit 1
>          fi
>          while true; do
>                  # Let other modules which scsi_debug depends on like sg
>                  # and t10_pi load first to ensure any commands sent to
>                  # the device are sent.
>                  sleep 1
> 
>                  # Now wait until userspace such as systemd-udevd and multipath
>                  # are done inspecting the newly exposed devices.
>                  COUNT=$(lsof /dev/sda | wc -l)
>                  if [[ $COUNT -ne 0 ]]; then
>                          echo "Sleeping ..."
>                          sleep 1;
>                  fi
>                  break
>          done
>          # Now you are safe to use scsi_debug exposed devices.
> 
>          # You are also free to remove it.
>          rmmod scsi_debug
>          if [[ $? -ne 0 ]]; then
>                  echo "scsi_debug rmmod failed at count $LOOP"
>                  exit 1
>          else
>                  echo "Loop $LOOP: OK!"
>          fi
>          let LOOP=$LOOP+1
> done
> 
> 
> Marking this bug as resolved and won't fix as this should hopefully suffice to
> document why we can't wait on scsi_debug_init() to fix this issue, and it must
> be addressed in userspace.
> 

