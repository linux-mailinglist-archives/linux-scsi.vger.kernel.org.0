Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13B434B652
	for <lists+linux-scsi@lfdr.de>; Sat, 27 Mar 2021 11:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhC0Kti (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 27 Mar 2021 06:49:38 -0400
Received: from comms.puri.sm ([159.203.221.185]:37894 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229883AbhC0Kti (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 27 Mar 2021 06:49:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id C484FDF73C;
        Sat, 27 Mar 2021 03:49:03 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nqox2EnRN_Jd; Sat, 27 Mar 2021 03:49:02 -0700 (PDT)
Message-ID: <9d0042fbfba9d33315f9eee7448b60aca8949431.camel@puri.sm>
Subject: Re: [PATCH v2 0/3] scsi: add runtime PM workaround for SD
 cardreaders
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        stern@rowland.harvard.edu, bvanassche@acm.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 27 Mar 2021 11:48:57 +0100
In-Reply-To: <20210112093329.3639-1-martin.kepplinger@puri.sm>
References: <20210112093329.3639-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Am Dienstag, dem 12.01.2021 um 10:33 +0100 schrieb Martin Kepplinger:
> revision history
> ----------------
> v2:
>  * move module parameter to sd
>  * add Documentation
> 
> v1:
> https://lore.kernel.org/linux-scsi/20210111152029.28426-1-martin.kepplinger@puri.sm/T/#t
> 
> 
> 
> hi,
> 
> In short: there are SD cardreaders that send MEDIA_CHANGED on
> runtime resume. We cannot use runtime PM with these devices as
> I/O basically always fails. I'd like to discuss a way to fix this
> or at least allow users to work around this problem:
> 
> For the full background, the discussion started in June 2020 here:
> https://lore.kernel.org/linux-scsi/20200623111018.31954-1-martin.kepplinger@puri.sm/
> 
> and I sent the first of these patches in August, as a reference:
> https://lore.kernel.org/linux-scsi/20200824190400.12339-1-martin.kepplinger@puri.sm/
> so this is where I'm following up on.
> 
> I'm not sure whether maintaining an in-kernel quirk for specific
> devices
> makes sense so here I suggest adding a userspace knob. This way
> there's at
> least a chance to use runtime PM for sd cardreaders that send
> MEDIA_CHANGED.
> 
> I'd appreciate any feedback.
> 
> Martin Kepplinger (3):
>   scsi: add expecting_media_change flag to error path
>   scsi: sd: add ignore_resume_medium_changed disk setting
>   scsi: sd: Documentation: describe ignore_resume_medium_changed
> 
>  Documentation/scsi/sd-parameters.rst | 14 ++++++++
>  drivers/scsi/scsi_error.c            | 36 +++++++++++++++++---
>  drivers/scsi/sd.c                    | 50
> +++++++++++++++++++++++++++-
>  drivers/scsi/sd.h                    |  1 +
>  include/scsi/scsi_device.h           |  1 +
>  5 files changed, 96 insertions(+), 6 deletions(-)
> 

hi James, Bart and all,

since this is absolutely needed for runtime pm with the SD device we
use I assume there are others that would benefit from this too. Do you
have any concerns or thoughts about this (logic and interface)?

the patches still apply.

thanks a lot,

                                     martin


