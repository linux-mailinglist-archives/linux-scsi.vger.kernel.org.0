Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6138C78F16
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jul 2019 17:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387974AbfG2PXL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Jul 2019 11:23:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38783 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387913AbfG2PXL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 29 Jul 2019 11:23:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id f5so19611199pgu.5
        for <linux-scsi@vger.kernel.org>; Mon, 29 Jul 2019 08:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZFPsZGrgmuO+Rmy7FDgE6Px2dxlnDjn3m4UlbO07otg=;
        b=iyj1cZiEVjIRd0ywLubkMmExle+uEmCtwc29XZVndGHJJUK8h74CTUZ0E25VkC5H+a
         LpUP69L9PiA2+ew9eI2FqtzTLaUHS0d71bcqRRiD8Z5GdVYRmw9nYt1+WdSwzYEEPRmy
         4V/HmbNAgdRGvCe56eBz0VO1vZyBDzpON0YndURAytAu4PqgQGZNomZc4Z94ee24Vuii
         hzpDOH21uTgfoHSYL/KQ9txQLiFUv+HLTKvqflKE+ZSURQDJjiat5RHYpTgTDcyOv4MN
         4wymnXuXJTJDIIlUcGCaBtfonfzeXcOrXtAS4szh/DaVJUp93Ix0lhEWjVCgPkIc9BW5
         Tz2Q==
X-Gm-Message-State: APjAAAUinxiCKXQOmZOZzipaGTszWHYJqyy1iiaTSpYAKKHXuTEPEkKX
        LsP6uqHJh/dw7RADBTuvs11nS4KY
X-Google-Smtp-Source: APXvYqxC7Nq4YI4Z8yo4d8kv8SjjiIl2V70otqH08c7g+R5BcA6E9JmcvFSLjLaofOLvWz/eNepX/Q==
X-Received: by 2002:a17:90a:c70c:: with SMTP id o12mr87424762pjt.62.1564413789928;
        Mon, 29 Jul 2019 08:23:09 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id h12sm70792516pje.12.2019.07.29.08.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 08:23:08 -0700 (PDT)
Subject: Re: [PATCH 4/4] Reduce memory required for SCSI logging
To:     Hannes Reinecke <hare@suse.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Jan Palus <jpalus@fastmail.com>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org
References: <20190726164855.130084-1-bvanassche@acm.org>
 <20190726164855.130084-5-bvanassche@acm.org>
 <5fcb2eb5-3eb2-d6ee-1846-fb26afe39046@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <5b5ca8a2-20ab-11bd-88d5-b2673f53f23e@acm.org>
Date:   Mon, 29 Jul 2019 08:23:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5fcb2eb5-3eb2-d6ee-1846-fb26afe39046@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/28/19 11:21 PM, Hannes Reinecke wrote:
> You've just disabled the prime reason why I did implement SCSI logging;
> namely to provide per-cpu buffers where messages can be printed into.
> 
> We can move to kmalloc (or even kvmalloc), but the per-cpu pointer need
> to be kept.

Hi Hannes,

The approach without my patch is as follows:
* Allocate a buffer for a single line of logging output.
* Call scnprintf() or another formatting function one or more times to
   produce a single line of logging output.
* Call dev_printk() to send that single line to the console.
* Free the allocated buffer.

With my patch applied that approach is retained. The only difference is 
how the buffer is allocated. I don't see why the SCSI logging code would 
need any per-cpu memory to avoid line splitting.

Bart.
