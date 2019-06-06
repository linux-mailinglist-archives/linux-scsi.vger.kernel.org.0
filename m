Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 234B837ED3
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Jun 2019 22:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfFFU3s (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Jun 2019 16:29:48 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34201 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFFU3s (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 Jun 2019 16:29:48 -0400
Received: by mail-qk1-f193.google.com with SMTP id t64so2357602qkh.1
        for <linux-scsi@vger.kernel.org>; Thu, 06 Jun 2019 13:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9F45VgGmU48BBEWkXpPf31Uw+s4wow3HKCBdXwfc5eU=;
        b=nu0FTfVYwMtUHUI4HWvoyU+g8tr5br9wkXzjQ8VmWDtlh5gcHpD/IHp/HDeGoaI0Le
         56AzHacZwV4TUCaaWTLb/sJCYPRjtW2YXqK66lGGgdR31k8OMmZrl6HqsCOeIzRAgmq/
         rSAYXV91oFgAEaAdm0Fj/Ocp5b/tb7L3ef/QfgA3MCygQLBBnwat+WOpstAM7MwrdNsk
         PMhamaChRWi5nmgUZ0FCxFPXvxQi+d1Und+wjrbgKDD7P6Rch+KV3r8OIsK8Y8RVwC4S
         /D2awNAgdXp9JADkdyyjH6cWrWqVgaJAOt2jL5kvszCeXC/qtRHr0VEYZxLEsDJdKVYv
         hEZA==
X-Gm-Message-State: APjAAAUb2dmRmtiKOYuzFl8aTCmJbEiIH7R3kGGsBKJ2wIoba+2jA1Fb
        kDyuU7Jh8oI9829xqKP8D0Grig==
X-Google-Smtp-Source: APXvYqyRie7Xki/OWLHOhZJTu+janaNr69tparuJvhmcP1ZD3BLx+GUdwXliNQpKYAkYVofKEW9y3A==
X-Received: by 2002:ae9:f00a:: with SMTP id l10mr41219378qkg.349.1559852987173;
        Thu, 06 Jun 2019 13:29:47 -0700 (PDT)
Received: from 2600-6c64-4e80-00f1-aa45-cafe-5682-368f.dhcp6.chtrptr.net (2600-6c64-4e80-00f1-aa45-cafe-5682-368f.dhcp6.chtrptr.net. [2600:6c64:4e80:f1:aa45:cafe:5682:368f])
        by smtp.gmail.com with ESMTPSA id v195sm1455800qka.28.2019.06.06.13.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 13:29:46 -0700 (PDT)
Message-ID: <3d7b95c12860b8445a3768bc7819d17ea91c7758.camel@redhat.com>
Subject: Re: [PATCH 1/3] scsi: Do not allow user space to change the SCSI
 device state into SDEV_BLOCK
From:   Laurence Oberman <loberman@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        James Smart <james.smart@broadcom.com>
Date:   Thu, 06 Jun 2019 16:29:45 -0400
In-Reply-To: <22ce1f30-a3c5-fc7d-0f1e-e2ca589682bb@acm.org>
References: <20190605201435.233701-1-bvanassche@acm.org>
         <20190605201435.233701-2-bvanassche@acm.org>
         <cec3e805-c834-a389-9666-bb79ed86057d@suse.de>
         <22ce1f30-a3c5-fc7d-0f1e-e2ca589682bb@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 2019-06-06 at 10:26 -0700, Bart Van Assche wrote:
> On 6/5/19 10:46 PM, Hannes Reinecke wrote:
> > Why not simply '-EPERM' ?
> 
>  > Translating a state into something else seems counterproductive.
> 
> Personally I'm OK with returning -EPERM for attempts from user space
> to 
> change the device state into SDEV_BLOCK. The state translation is 
> something that was proposed about two months ago (see also 
> https://www.mail-archive.com/linux-scsi@vger.kernel.org/msg82610.html
> ).
> 
> > And, while we're at it:
> > The only meaningful states to be set from userspace are 'RUNNING',
> > 'OFFLINE', and 'BLOCK'.
> > Everything else relates to the internal state machine and really
> > shouldn't be touched from userspace at all.
> > So I'd rather filter out everything _but_ the three states, avoid
> > similar issue in the future.
> 
> Can you please clarify why you think it is useful to change the SCSI 
> device state from user space into SDEV_BLOCK? As one can see in 
> scsi_device_set_state() transitions from SDEV_BLOCK into the
> following 
> states are allowed: SDEV_RUNNING, SDEV_OFFLINE,
> SDEV_TRANSPORT_OFFLINE 
> and SDEV_DEL. The mpt3sas driver and also the FC, iSCSI and SRP 
> transport drivers all can call scsi_internal_device_unblock_nowait()
> or 
> scsi_target_unblock(). So at least for this LLD and these transport 
> drivers if the device state is set to SDEV_BLOCK from user space
> that 
> change can be overridden any time by kernel code. So I'm not sure it
> is 
> useful to change the device state into SDEV_BLOCK from user space.
> 
> Bart.

I have never used block (SDEV_BLOCK) from userspace, only ever running
and offline
I did not even know that was a possibility.
What would that be possibly used for.
Regards Laurence


