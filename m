Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57A9737B02
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Jun 2019 19:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbfFFR0K (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Jun 2019 13:26:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37847 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfFFR0K (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 Jun 2019 13:26:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id a23so1925831pff.4
        for <linux-scsi@vger.kernel.org>; Thu, 06 Jun 2019 10:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UUVcFWj7KF4GALBEqZdM1SoUMtmtgUHPWghhh+l71SQ=;
        b=LhwxnVCR1zWVKIbOks5ly+dQgXwZFEyk/0PLdHBDL5mIKk/zr3oWz6lN/w+CBq1k+K
         RTQ6fMcArT34/+LF1reelFKkgC+AnQt5URbtrQbMawzS5K0oji++EltGOAJ6Bw4shpIJ
         O4cjjHNdDssvEyRsYOrfhigOt2mGP/SPqkTe4v2Uv3o5xJGkuZKB9SPCIZlv5JEGioW+
         P0npXO7t54IQh1uUFw20SXeqdFoS8j0fUW8PRwVYFZrZvefw5dvOYvKw7CKN3Ob5dvW7
         rr6kAFK0nVKoh4DJrRXfY4IuhNsnNZkCWXd5lnucy1Wm6ER0/sUjkZrpYeyGgY9YXbio
         IjMg==
X-Gm-Message-State: APjAAAUeePc7yvYgnh64Wz14yTO+rANKvq2z1FeYRiCM7Y5qRRTFWVAH
        92/OQA6SPJQI7ZAL1JaSVIU=
X-Google-Smtp-Source: APXvYqywKzH2Ly1M9Avtz4KPMilRAXaunIKlpa9KV4yXLNtMLBKkhkxgw5fgy/nOGD4z6BiwkeUsEA==
X-Received: by 2002:a63:e408:: with SMTP id a8mr1825800pgi.146.1559841969498;
        Thu, 06 Jun 2019 10:26:09 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id x8sm2996806pfa.46.2019.06.06.10.26.04
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 10:26:05 -0700 (PDT)
Subject: Re: [PATCH 1/3] scsi: Do not allow user space to change the SCSI
 device state into SDEV_BLOCK
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        James Smart <james.smart@broadcom.com>
References: <20190605201435.233701-1-bvanassche@acm.org>
 <20190605201435.233701-2-bvanassche@acm.org>
 <cec3e805-c834-a389-9666-bb79ed86057d@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <22ce1f30-a3c5-fc7d-0f1e-e2ca589682bb@acm.org>
Date:   Thu, 6 Jun 2019 10:26:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cec3e805-c834-a389-9666-bb79ed86057d@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/5/19 10:46 PM, Hannes Reinecke wrote:
> Why not simply '-EPERM' ?
 > Translating a state into something else seems counterproductive.

Personally I'm OK with returning -EPERM for attempts from user space to 
change the device state into SDEV_BLOCK. The state translation is 
something that was proposed about two months ago (see also 
https://www.mail-archive.com/linux-scsi@vger.kernel.org/msg82610.html).

> And, while we're at it:
> The only meaningful states to be set from userspace are 'RUNNING',
> 'OFFLINE', and 'BLOCK'.
> Everything else relates to the internal state machine and really
> shouldn't be touched from userspace at all.
> So I'd rather filter out everything _but_ the three states, avoid
> similar issue in the future.

Can you please clarify why you think it is useful to change the SCSI 
device state from user space into SDEV_BLOCK? As one can see in 
scsi_device_set_state() transitions from SDEV_BLOCK into the following 
states are allowed: SDEV_RUNNING, SDEV_OFFLINE, SDEV_TRANSPORT_OFFLINE 
and SDEV_DEL. The mpt3sas driver and also the FC, iSCSI and SRP 
transport drivers all can call scsi_internal_device_unblock_nowait() or 
scsi_target_unblock(). So at least for this LLD and these transport 
drivers if the device state is set to SDEV_BLOCK from user space that 
change can be overridden any time by kernel code. So I'm not sure it is 
useful to change the device state into SDEV_BLOCK from user space.

Bart.
