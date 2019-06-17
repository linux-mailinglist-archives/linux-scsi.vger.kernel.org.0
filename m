Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F24FE49617
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 01:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfFQXw3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 19:52:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46512 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfFQXw3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 17 Jun 2019 19:52:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id v9so6600957pgr.13;
        Mon, 17 Jun 2019 16:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rT1Ry9CXDU/Gof/gNESKymfMi9a8wIc43QBygQM/oWk=;
        b=mJ8Jlyf5c5CQr32tFtn4QQKxZrgQtMFLlzgKU1/UcwURQq2ZCFE1OGJtEtb3WAV3Tk
         ZNlvZ8SOnjROFsW0jpfyIrzcr4T3FYEds3Rt9DsWO03Nrg9hfEMQgoArhGc6beUsxsxf
         Jc/qlKMvXm9QK1r+IHwTE2rumUeI71Gx9WvW+IdZturb9TrmX9S3mwPFUb1tfkSm0sso
         geYJpvOXgTXgmXcG+gGg3FNEvYgJaKV4gAt144FB1C+7lAhOh7so1ZM8nrgI4dZTrgT9
         Np3epluPIoVTGX9eJmW7p5kUsGVLO7OTleZj4rBlhLikyV3whn3gZv2zG7nK0L/6QnQw
         pu8Q==
X-Gm-Message-State: APjAAAVUBRH8HZSxjZCPsHsddXOdjqTpXuEfWgJbA5pCQPmLBZNNDgKu
        ffAvLtnIIgormnADur5a5ps=
X-Google-Smtp-Source: APXvYqznUwe7i1jFQEHoTI8nFDF4yUuM+GrXTOznm/OWpDdnoDTWVknSAtGeEiPT6OHomWHWWX0woA==
X-Received: by 2002:a17:90a:2ec2:: with SMTP id h2mr1867192pjs.119.1560815548541;
        Mon, 17 Jun 2019 16:52:28 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l20sm11750101pff.102.2019.06.17.16.52.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 16:52:27 -0700 (PDT)
Subject: Re: [PATCH V4 00/16] use sg helper to operate scatterlist
To:     Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
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
References: <20190617030349.26415-1-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <25be959c-82fc-996e-76ed-c1fe7b4dce5d@acm.org>
Date:   Mon, 17 Jun 2019 16:52:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617030349.26415-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/16/19 8:03 PM, Ming Lei wrote:
> Scsi MQ makes a large static allocation for the first scatter gather
> list chunk for the driver to use.  This is a performance headache we'd
> like to fix by reducing the size of the allocation to a 2 element
> array.  Doing this will break the current guarantee that any driver
> using SG_ALL doesn't need to use the scatterlist iterators and can get
> away with directly dereferencing the array.  Thus we need to update all
> drivers to use the scatterlist iterators and remove direct indexing of
> the scatterlist array before reducing the initial scatterlist
> allocation size in SCSI.

For all patches in this series except 9/16 and 11/16, please add the 
following:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
