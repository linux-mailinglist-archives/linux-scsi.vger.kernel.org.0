Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D651812642
	for <lists+linux-scsi@lfdr.de>; Fri,  3 May 2019 04:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfECCA2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 2 May 2019 22:00:28 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38098 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfECCA1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 2 May 2019 22:00:27 -0400
Received: by mail-qt1-f193.google.com with SMTP id d13so5084465qth.5
        for <linux-scsi@vger.kernel.org>; Thu, 02 May 2019 19:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=usFhnL80OdC3g7f4gtI3ut9K4ZtEGg8DGGbgC73Xvks=;
        b=aqBQW48joLc2ukXk/EqlcA4jTbaewYdZitKXODwwXncVpdRkmudZj2/fUW8CAZ7Nl+
         wgShbRj71xi1rS//8v6e8oFnGRaghBc/REeKempd8q5kXmhJ0OJNyi8POLJR0Yib+Gus
         XCJ2MzO+FJJFQYpP+GBB+kQ42CHhXnbvllhx4pOU5pUBFLIatjzzMjkrcsHROIH48hcy
         Js0LnH7No+x2XP3L8T5wpi4vJBHeW0QHh2+ep88ROX+zv/ZIopHrPuJfNuYYpFVOWB9n
         achi3YDSpUcIPmN1tsT6ZBx6p6db7RPkWYimN/uWmxzazZ4VL9a7LUnMNXDUk79hvbfu
         obBw==
X-Gm-Message-State: APjAAAX5/DmwCXtjGIGNmGlG+nbRKLnOCud5J+YsDab+eH2xJaIUJwta
        YKeISHzQ1ctmT/JYa7FHWad9sQ==
X-Google-Smtp-Source: APXvYqw+xX49n+bDKq072IK0Ig9HZWkFDUjsGlFkgu8sdO9R1WDhvcFvUEpDciEQMgD/gX/knTB2gQ==
X-Received: by 2002:a0c:aed4:: with SMTP id n20mr6038370qvd.136.1556848826289;
        Thu, 02 May 2019 19:00:26 -0700 (PDT)
Received: from 2600-6c64-4e80-00f1-336a-6920-3806-8b87.dhcp6.chtrptr.net (2600-6c64-4e80-00f1-336a-6920-3806-8b87.dhcp6.chtrptr.net. [2600:6c64:4e80:f1:336a:6920:3806:8b87])
        by smtp.gmail.com with ESMTPSA id l127sm356169qkc.81.2019.05.02.19.00.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 19:00:25 -0700 (PDT)
Message-ID: <156112a88d3bc8e2edc32253e4b19f62b6254580.camel@redhat.com>
Subject: Re: Kernel panic w/ message request_threaded_irq ->
 qla2x00_request_irqs -> qla2x00_probe_one -> mod_timer
From:   Laurence Oberman <loberman@redhat.com>
To:     tomkcpr@mdevsys.com, Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org
Date:   Thu, 02 May 2019 22:00:24 -0400
In-Reply-To: <8ab70c91-9e11-4e8b-f4cf-d705bec1d4c1@mdevsys.com>
References: <012262e1-697c-577b-cf99-bbd960661c70@mdevsys.com>
         <749372e4ebd5857ecc9b0947d6f8582a6f199bf4.camel@redhat.com>
         <1555342788.161891.95.camel@acm.org>
         <d6cef9727e9446101a9913651d58df60914c7b61.camel@redhat.com>
         <fa7e07d1-5266-4f55-b3f5-f41a85e679d8@mdevsys.com>
         <8ab70c91-9e11-4e8b-f4cf-d705bec1d4c1@mdevsys.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, 2019-04-28 at 12:11 -0400, TomK wrote:
> On 4/15/2019 10:26 PM, TomK wrote:
> > On 4/15/2019 3:35 PM, Laurence Oberman wrote: 
> > > On Mon, 2019-04-15 at 08:39 -0700, Bart Van Assche wrote: 
> > > > On Mon, 2019-04-15 at 08:55 -0400, Laurence Oberman wrote: 
> > > > > On Sun, 2019-04-14 at 23:25 -0400, TomK wrote: 
> > > > > > Hey All, 
> > > > > > 
> > > > > > I'm getting a kernel panic on an Gigabyte GA-890XA-UD3 
> > > > > > motherboard 
> > > > > > that 
> > > > > > I've got a QLE2464 card in as a target (FC).  The kernel
> > > > > > has 
> > > > > > been 
> > > > > > crashing / panicking in the last 1-2 months about once a 
> > > > > > week.  Before 
> > > > > > that, it was rock solid for 4-5 years.  I've upgraded to
> > > > > > kernel 
> > > > > > 4.18.19 
> > > > > > but that hasn't made much of a difference.  Since the
> > > > > > message 
> > > > > > includes 
> > > > > > qla2x00_request_irqs I thought I would try here first. 
> > > > > > 
> > > > > > Tried to get more info on this but: 
> > > > > > 
> > > > > > 1) Keyboard doesn't work and locks up when the panic
> > > > > > occurs.  No 
> > > > > > USB 
> > > > > > ports work.  Tried the PS/2 port but nothing. 
> > > > > > 
> > > > > > 2) Unable to capture a kdump.  Can't get to the kdump
> > > > > > vmcore due 
> > > > > > to 
> > > > > > 1). 
> > > > > > 
> > > > > > The two screenshots is pretty much all I can capture. 
> > > > > > Tried 
> > > > > > things 
> > > > > > like 
> > > > > > clocksource=rtc in the kernel parms and disabling hpet1
> > > > > > but 
> > > > > > apparently I 
> > > > > > haven't disabled it everywhere since it still shows up. 
> > > > > > 
> > > > > > Wondering if anyone recognizes these messages or has any
> > > > > > idea 
> > > > > > what 
> > > > > > could 
> > > > > > be the issue here?  Even a hint would be appreciated. 
> > > > > > 
> > > > >  
> > > > > Hello Tom 
> > > > > I have had similar issues and reported them to 
> > > > > Himanshu@Cavium 
> > > > > I have kept all my target servers at kernel 4.5 as it been
> > > > > the only 
> > > > > version that has always been stable. 
> > > > > If your motherboard has an NMI (virtual or physical) set all
> > > > > of 
> > > > > these 
> > > > > in /etc/sysctl.conf 
> > > > > Run sysctl -a;dracut -f and reboot 
> > > > > 
> > > > > kernel.nmi_watchdog = 1 
> > > > > kernel.panic_on_io_nmi = 1 
> > > > > kernel.panic_on_unrecovered_nmi = 
> > > > > kernel.unknown_nmi_panic = 1 
> > > > > 
> > > > > When the issue shows up press the virtual/physical NMI 
> > > > > 
> > > > > This is with the assumption that generic kdump is properly
> > > > > setup 
> > > > > and 
> > > > > dmesg | grep crash shows memory resrved by the crashkernel
> > > > > and that 
> > > > > you 
> > > > > have tested kdump manually. 
> > > > > 
> > > > > Other options are use a USB serial port to capture the full
> > > > > log if 
> > > > > you 
> > > > > cannot get kdump to work. 
> > > >  
> > > > That approach may provide further evidence about kernel bugs
> > > > but it 
> > > > is not 
> > > > guaranteed that that approach will lead to a solution. It would
> > > > help 
> > > > if 
> > > > either or both of you could do the following on a test system: 
> > > > * Check out branch qla2xxx-for-next of my kernel repo on
> > > > github 
> > > >    (https://github.com/bvanassche/linux/tree/qla2xxx-for-next).
> > > >  
> > > > * Enable lockdep and KASAN in the kernel config
> > > > (CONFIG_PROVE_LOCKING 
> > > > and 
> > > >    CONFIG_KASAN). 
> > > > * Build and install that kernel. 
> > > > * Run your favorite workload. 
> > > > 
> > > > Please note that the qla2xxx-for-next branch is based on the
> > > > v5.1-rc1 
> > > > kernel 
> > > > and hence should not be installed on any production system. 
> > > > 
> > > > Thanks, 
> > > > 
> > > > Bart. 
> > >  
> > > Hello Bart 
> > > OK, I will get to this by Thursday, wont be able to change the 
> > > targetserver kernel until then. 
> > > Regards 
> > > Laurence 
> > > 
> >  
> > Same.  I'll try this out closer to the weekend. 
> > 
> > Not an NMI motherboard.  This is a 9-10 year old AMD board meant as
> > a desktop or home server. 
> > 
> > I'll have to read more about the USB Serial port to capture further
> > info.  That's interesting. 
> > 
> > For the time being, I've disabled HPET in BIOS.  ( Appears the
> > kernel boot parameter method wasn't enough. ) 
> > 
> > 
> 
> Hey Guy's,
> Did some of what you suggested, including the USB serial setup:
> 1) One of DB9 RS232 Serial Null Modem Cable F/F
> 2) Two of USB to RS232 Serial Port DB9 9 Pin Male
> however, when the kernel came down it took the USB support with it
> and so minicom went offline:
>  CTRL-A Z for help |115200 8N1 | NOR | Minicom 2.6.2  | VT102 |     
> Offline
> But I did enable full logging for the QLA module:
> echo 0x7fffffff >
> /sys/module/qla2xxx/parameters/ql2xextended_error_logging
> Did all that, minus the Kernel v5.1-rc1 implementation, and this is
> what was picked up from the minicom USB to Serial capture before
> things went south:
> 1235905 ^Mqla2xxx [0000:04:00.0]-e818: is_send_status=1, cmd-
> >bufflen=512, cmd->sg_cnt=1, cmd-
> >                                                                    
>            
> dma_data_directi                                                     
>                                                                      
>                              on=1
> se_cmd[0000                                                          
>                                                                      
>                         00009c9ea758]
> qp                                                                   
>                                                                      
>                 0
> 1235906 ^Mqla2xxx [0000:04:00.0]-e818: is_send_status=1, cmd-
> >bufflen=4096, cmd->sg_cnt=0,
> cmd-                                                                 
>               
> >dma_data_direct                                                     
>                                                                      
>                              ion=2
> se_cmd[000                                                           
>                                                                      
>                        0000096ae11b7]
> q                                                                    
>                                                                      
>               p 0
> 1235907 ^Mqla2xxx [0000:04:00.0]-e818: is_send_status=1, cmd-
> >bufflen=20480, cmd->sg_cnt=0,
> cmd                                                                  
>              
> ->dma_data_direc                                                     
>                                                                      
>                              tion=2
> se_cmd[00                                                            
>                                                                      
>                      
> 0000001738f793]                                                      
>                                                                      
>                              qp 0
> 1235908 ^Mqla2xxx [0000:04:00.0]-e818: is_send_status=1, cmd-
> >bufflen=20480, cmd->sg_cnt=0,
> cmd                                                                  
>              
> ->dma_data_direc                                                     
>                                                                      
>                              tion=2
> se_cmd[00                                                            
>                                                                      
>                      
> 000000e8160a90]                                                      
>                                                                      
>                              qp 0
> 1235909 ^MDetected MISCOMPARE for addr: 0000000033045258 buf:
> 00000000f9849912
> 1235910 ^MTarget/fileio: Send MISCOMPARE check condition and sense
> 1235911 ^Mqla2xxx [0000:04:00.0]-e818: is_send_status=1, cmd-
> >bufflen=512, cmd->sg_cnt=0, cmd-
> >                                                                    
>            
> dma_data_directi                                                     
>                                                                      
>                              on=2
> se_cmd[0000                                                          
>                                                                      
>                         0000363ae214]
> qp                                                                   
>                                                                      
>                 0
> 1235912 ^Mqla2xxx [0000:04:00.0]-e817: Skipping EXPLICIT_CONFORM and
> CTIO7_FLAGS_CONFORM_REQ
> fo                                                                   
>              r FCP READ w/
> no                                                                   
>                                                                      
>                n GOOD status
> 1235913 ^Mqla2xxx [0000:04:00.0]-e874:2: qlt_free_cmd:
> se_cmd[000000001db805fd] ox_id 00c8
> 1235914 ^Mqla2xxx [0000:04:00.0]-e872:2: qlt_24xx_atio_pkt_all_vps:
> qla_target(0): type 6
> ox_id                                                                
>                  00db
> 1235915 ^Mqla2xxx [0000:04:00.0]-e872:2: qlt_24xx_atio_pkt_all_vps:
> qla_target(0): type 6
> ox_id                                                                
>                  00dc
> 1235916 ^Mqla2xxx [0000:04:00.0]-e874:2: qlt_free_cmd:
> se_cmd[00000000f67a701f] ox_id 00c9
> 1235917 ^Mqla2xxx [0000:04:00.0]-e872:2: qlt_24xx_atio_pkt_all_vps:
> qla_target(0): type 6
> ox_id                                                                
>                  00dd
> 1235918 ^Mqla2xxx [0000:04:00.0]-e872:2: qlt_24xx_atio_pkt_all_vps:
> qla_target(0): type 6
> ox_id                                                                
>                  00de
> 
> On an earlier crash, captured the attached image.  This time there
> was nothing on the monitor and the keyboard didn't refresh it.  No
> signal. 
> When looking this up, closest I could see online is the following:
> 
https://target-devel.vger.kernel.narkive.com/XiM5Csx8/luns-become-unavailable-with-current-git-head
> They too run ESXi . 
> To read the file I used the AnsiEsc plugin for VIM: 
> https://www.vim.org/scripts/script.php?script_id=302
> This started to occur once had a VMware based MySQL and PostgreSQL
> cluster configured.  Takes a few days for the issue to occur so from
> that perspective, appears to be memory related.
> Firmware that I'm using is:
>     supported_classes   = "Class 3"
>     supported_speeds    = "1 Gbit, 2 Gbit, 4 Gbit"
>     symbolic_name       = "QLE2464 FW:v8.04.00 DVR:v10.00.00.05-k"
> Targetcli, rtslib and configshell versions I'm using are:
> 
> # rpm -aq|grep -Ei "targetcli|rtslib|configshell" 
> python-rtslib-3.0.pre4.9~g6fd0bbf-1.el6.noarch 
> python-configshell-1.1.fb4-1.el6.noarch 
> targetcli-3.0.pre4.5~ga125182-1.el6.noarch
> 
> 
> -- 
> Thx,
> TK.

I missed this email, Been buried in customer cases.
I also need to still run some tests.
Sorry, reading now

