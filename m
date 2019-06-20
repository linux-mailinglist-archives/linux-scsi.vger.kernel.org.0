Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28CCA4D21A
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 17:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfFTP0T (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 11:26:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44445 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfFTP0T (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 11:26:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so1852226pfe.11
        for <linux-scsi@vger.kernel.org>; Thu, 20 Jun 2019 08:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5YtHeSSZnkhl+3BTpsEsn+RDYks24VzvyAkDya+yz8E=;
        b=rR+2Q7R8t5IrjAiDuN6Tx8SOF6G+lwLW+KHnEw2lgddYjQYf1wgNmfShKb3qIJOQJO
         fGM5h3KBJTTVzkqq+D/x4qQUJE2sd1pH6NmZ8VxnIibUYl3+fE7qdRIKazLIx16CT7rm
         WHIwVvrtkvJbtx7wxAeL0KJkqQC5jCp2Z8AMHjg9KPlb1XebTs6ahkfyZ90vbPE4bwRM
         N9MRFQaAt9TNktSjkZEvuTfnUqaxQjb92K8WKQk8uXSrAx2A1CaTEI4ONA3jmhb8/BU3
         nAoA/yz5W0yI/w3aH7vtvk7lootqde10/6lioDf6jobY5coRqyRvPkjsA5KvXPVwUN3P
         WWtA==
X-Gm-Message-State: APjAAAXpknRvkkT4dsrp96JhMvVIs6ULqBVj5d3j4matXUZUA7PgjUyb
        N5UoTrsde5bCq4PLIsRsm7A=
X-Google-Smtp-Source: APXvYqxSXSWzwFAFFxkre9ees2FWmf1uJa4a9EW3DrKenCku9kHRMF3B2mLUSBH9+Aj7pNIxJ48fgQ==
X-Received: by 2002:a17:90a:d997:: with SMTP id d23mr199087pjv.84.1561044379027;
        Thu, 20 Jun 2019 08:26:19 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id u2sm102656pjv.9.2019.06.20.08.26.17
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 08:26:18 -0700 (PDT)
Subject: Re: [PATCH] scsi: mvumi: fix build warning
To:     Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        "Ewan D . Milne" <emilne@redhat.com>
References: <20190620062622.9979-1-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <6898a1d7-8d5a-aeed-1b63-65bd30ab379a@acm.org>
Date:   Thu, 20 Jun 2019 08:26:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620062622.9979-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/19/19 11:26 PM, Ming Lei wrote:
> The local variable 'sg' should be initialized in the failure path of
> mvumi_make_sgl(), otherwise the following build warning is triggered:
> 
> 	In file included from include/linux/pci-dma-compat.h:8,
> 	                 from include/linux/pci.h:2408,
> 	                 from drivers/scsi/mvumi.c:13:
> 	drivers/scsi/mvumi.c: In function 'mvumi_queue_command':
> 	include/linux/dma-mapping.h:608:34: warning: 'sg' may be used uninitialized in this function
> 	+[-Wmaybe-uninitialized]
> 	 #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
> 	                                  ^~~~~~~~~~~~~~~~~~
> 	drivers/scsi/mvumi.c:192:22: note: 'sg' was declared here
> 	  struct scatterlist *sg;
>                        ^~
> Fixed it by removing the local variable reference in failure path.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
