Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8FFE4C1A4
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Jun 2019 21:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfFSTnv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 19 Jun 2019 15:43:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45858 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfFSTnu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 19 Jun 2019 15:43:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id s21so208391pga.12;
        Wed, 19 Jun 2019 12:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vkDuWR4Ufpj0xciDQcbKjPFVsG7k2MUKXN7wSLo/irQ=;
        b=naWKF5qxbT+Oz6omRJ46geiqeLoZoZHtQbEOxN+grTO1SdVlBwo50NfGxQmc/FFlud
         bRuio6JuptysRHXJLBLP9e0onk5K2zobBF/ZgXR55k2OnsVIk1CLgLAKvOYpsbqLfbgn
         8lz1jH0IIET/SR2arPzhvk5ZR/XkClOGMqhG34sWHKfh+Z/FaC/Ic8Zzrio9htfk0Vov
         jX5TgVwNESXuaFck3KieYKrHoP0ifxE6FS8PdsWvCgLX49YosANv8zPNgJFXc9iaXXdG
         L5GmXDGIoIsw2rCQfkztD+VLRN6YveY5PAH4N0s/sqdMvEUs64o/3c+8H/UGixsSUcIS
         0Hnw==
X-Gm-Message-State: APjAAAXkTUCyLc6jGutDKRt/hS+K8P+APD3lvohkc2MAoj282LMxRlAZ
        fEfCSsFtyIy5eXCyC/qZXCgv4hHT7B8=
X-Google-Smtp-Source: APXvYqzu0qVkLU1Bjj2t90oYtlQ8S7ihvZbF2diaNzgHmiBEJPWw0dSSJHUCdg1/QQ9BlByLhmOSHQ==
X-Received: by 2002:a63:5a02:: with SMTP id o2mr8900735pgb.93.1560973429816;
        Wed, 19 Jun 2019 12:43:49 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id r4sm2325798pjd.28.2019.06.19.12.43.48
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 12:43:48 -0700 (PDT)
Subject: Re: [PATCH V5 00/16] use sg helper to operate scatterlist
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-scsi@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>,
        "Juergen E . Fischer" <fischer@norbit.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-usb@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Block <bblock@linux.ibm.com>
References: <20190618013757.22401-1-ming.lei@redhat.com>
 <yq11rzqzacx.fsf@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <3df71d64-78fb-c6fc-f456-a0b626abff3b@acm.org>
Date:   Wed, 19 Jun 2019 12:43:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <yq11rzqzacx.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/18/19 5:29 PM, Martin K. Petersen wrote:
> I applied this series with a bunch of edits and clarifying comments. It
> was quite the nightmare to rebase 5.3/scsi-queue to satisfy the ordering
> requirements, locate the scattered fixes, tweak tags, etc. Hope I got
> everything right.

Hi Martin,

Do you perhaps plan to push out these patches at a later time? It seems 
like that branch has not been updated recently:

$ git show --format=fuller mkp-scsi/5.3/scsi-queue | head -n7
commit f3e88ad00f58e9a05986be3028b2ed8654c601c9
Author:     Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
AuthorDate: Fri May 31 08:14:43 2019 -0400
Commit:     Martin K. Petersen <martin.petersen@oracle.com>
CommitDate: Fri Jun 7 10:17:06 2019 -0400

     scsi: mpt3sas: Update driver version to 29.100.00.00

Thanks,

Bart.
