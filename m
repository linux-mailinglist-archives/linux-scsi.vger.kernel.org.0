Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D63003053B
	for <lists+linux-scsi@lfdr.de>; Fri, 31 May 2019 01:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfE3XKS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 May 2019 19:10:18 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:35379 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfE3XKS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 30 May 2019 19:10:18 -0400
Received: by mail-pg1-f175.google.com with SMTP id t1so2880859pgc.2
        for <linux-scsi@vger.kernel.org>; Thu, 30 May 2019 16:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ckm3QUf0VW3/Mh/uWQLUuRjxyVfOTTCOxznh6XqNv18=;
        b=dORBwwdMIxTIpW2q3uV/KbjS/psSUQiDlcl8DS8m2ckMMYEUIaiafRp75u4TaVlzEZ
         dKN1MgVTtH8vuPYBZRAO0PRaWkZTG3zgGzkHwQK9ekAUzQ5wd2pOpm9jmZ9AdNxi5pSm
         /9zWiXuDX1ZA7PB77Up1J6m3JT0wf/BaviX4tbimOYeOEBaxCIkw5t7P4zYG66kb617Z
         YYWz1kwJqyFEhSLuyjDbHAooiuKKRTKb6oS+6Hf7S8rlx22vO8TUWcT+LKl4zq7TawuW
         Fh5kvyhWclPHSp1oRjyzt6p9lm/C8t4g631GQKljR2mJEvvpO/pf0l+QwibZ/3qFJ7e7
         zirQ==
X-Gm-Message-State: APjAAAW/FqOV7+ShkFSlSsCkPDlHlZENKcAp4+w8XApS4PfmcL7Q9mOG
        whmRijtaq1BNlRYOzEVOOAZv8jY4
X-Google-Smtp-Source: APXvYqynz307LU05oXvhJDHia/MTHNJWmEOBOvW1EzkBYifkE0a/nd02CceFmsApw/k8+Dmd1YAyTw==
X-Received: by 2002:a62:7610:: with SMTP id r16mr6374098pfc.69.1559257817562;
        Thu, 30 May 2019 16:10:17 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l21sm3927243pff.40.2019.05.30.16.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 16:10:16 -0700 (PDT)
Subject: Re: FICON target support
To:     Christian Svensson <christian@cmd.nu>, linux-scsi@vger.kernel.org
Cc:     fcoe-devel@open-fcoe.org
References: <CADiuDASOCJbnwLs-LEp0aCX+T4dMvFfKQv_zsypHW-iSF8wW=Q@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <5c5609d8-e4b4-3561-ece9-93746fd46206@acm.org>
Date:   Thu, 30 May 2019 16:10:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CADiuDASOCJbnwLs-LEp0aCX+T4dMvFfKQv_zsypHW-iSF8wW=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/26/19 8:51 AM, Christian Svensson wrote:
> I am doing some preliminary scouting of how one could add support for
> FICON (FC-SB-3 specifically). I am mostly interested in Linux being
> able to act as a FICON target for now.
> 
> The TL;DR summary for FICON is that it uses Fibre Channel just like FCP/SCSI
> up to but not including the FC-4 (FCP) layer. At that point it uses its own
> SBCCS layer.
> 
> FICON is used by IBM mainframes to interface peripherals like tape, disk,
> printers, card punchers/readers, etc. It is more like a mainframe USB/Firewire
> than SCSI in that regard.
> 
> I would prefer to implement my peripherals in user-space, I don't see any
> convincing case for having e.g. a virtual tape drive running in kernel space.
> The I/O heavy disks would probably benefit from being in kernel space, but I am
> OK limiting the initial scope.
> 
> I am 100% new to the SCSI and Fibre Channel subsystem in Linux, and I
> do not even know if the current HBAs support sending frames without FCP
> but after scouting the code it does seem that it might work out - FCP
> seems decoupled enough.
> 
> If you want to learn more the standard document Wireshark has an
> implementation of the protocol (packet-fcsb3.c/h). If you want all the details
> you will sadly have to pay $60 and buy it from INCITS at
> https://webstore.ansi.org/Standards/INCITS/INCITS3742003S2013.
> Fwiw, FICON uses FC type 0x1B and 0x1C.
> 
> Any thoughts or ideas where you would start? Do you see any future for this
> addition to the kernel?

Hi Chris,

I'm not sure what the best approach is for the initiator functionality. 
For the target functionality you may want to have a look at tcmu 
(Documentation/target/tcmu-design.txt and 
drivers/target/target_core_user.c). An existing FC target driver is 
available in drivers/scsi/qla2xxx/tcm_qla2xxx.c. A diagram that shows 
the different functional blocks in TCM is available at 
https://en.wikipedia.org/wiki/LIO_(SCSI_target) (LIO is another name for 
TCM).

Bart.
