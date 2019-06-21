Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7DBB4DF60
	for <lists+linux-scsi@lfdr.de>; Fri, 21 Jun 2019 05:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfFUDqo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 23:46:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39732 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfFUDqo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 23:46:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id 196so2658442pgc.6
        for <linux-scsi@vger.kernel.org>; Thu, 20 Jun 2019 20:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NnAiAF1fYWcEGxJ/Ma3sG0eMqd6dYJPsTEBWMU/2Zcc=;
        b=PB2OZtFgb2B+gzviDi/iWopoZKS/SzcT8i8mi1HpcgN8MXYAVzbzr4URXopM/HNJTr
         sXjMIyK4f22z5wKsnxRgcvSe94CTl+d7oM+zUGHGLT5e2UcvEfMF6CI67GfNS5Ohh54I
         l5kLhHDpePiHhD+liJ2beVftlyHkiZSNcPHVBB6lhyAjZ0pl5rQ8h60k8X4FO1OwWUZn
         qjjf28VwRSL+WvIm81loKD+AjCE15ueU/PWl0ASRcdZFrq3CQMgTtSbGfcZfQJiY/Uc3
         BHyUya0ETFj3Pd5VPKe07+lw5u2Edqu2FCH17BN4DsFiQq2jo0j9bHZobbPGTjYQr/4i
         F6DA==
X-Gm-Message-State: APjAAAXcqIJXSmOzZm5IKdDgf0EsQoIMshGqZskyXA1ZPx+2tNeSH9SJ
        uK19vvCST2hNQw7YAKWIkf8=
X-Google-Smtp-Source: APXvYqyTPHD3K5Nj72uU73zXM69C9ZTH4NUm1b+28CbKHesK+4Klr8ne5044qtiOrZ4kXNEpjyOqYQ==
X-Received: by 2002:a17:90a:9bca:: with SMTP id b10mr3574087pjw.90.1561088803383;
        Thu, 20 Jun 2019 20:46:43 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:7935:9a09:9bb0:db40])
        by smtp.gmail.com with ESMTPSA id j8sm888505pfi.148.2019.06.20.20.46.41
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 20:46:42 -0700 (PDT)
Subject: Re: [PATCH] sd_zbc: Fix report zones buffer allocation
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>
References: <20190620034812.3254-1-damien.lemoal@wdc.com>
 <b6f250ad-0473-4643-8611-e395295e0379@acm.org>
 <BYAPR04MB5816D6F4B36032ADEF6A8482E7E70@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <18ab1c5d-338b-7464-46f2-911492aa548c@acm.org>
Date:   Thu, 20 Jun 2019 20:46:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816D6F4B36032ADEF6A8482E7E70@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/20/19 5:58 PM, Damien Le Moal wrote:
> The REPORT_ZONES command is executed using scsi_execute_req(). Can we pass a
> vmalloc-ed buffer to that function ? It does look like it since scsi_execute_rq
> calls bio_rq_map_kern() which then calls bio_map_kern() which goes through the
> list of pages of the buffer. Just would like to confirm I understand this correctly.
> 
> My concern with using vmalloc is that the worst case scenario will result in all
> pages of the buffer being non contiguous. In this case, since the report zones
> command cannot be split, we would need to limit the allocation to max_segments *
> page size, and that can be pretty small for some HBAs.
> 
> Another reason I did not pursue the vmalloc route is that the processing of the
> report zones reply to transform zone information into struct blkzone is really
> painful to do with a vmalloced buffer as every page of the buffer needs to be
> kmap()/kunmap(). The code was like that when REPORT ZONES was processed as a
> BIO/request, but it was a lot of code for not much to be done. Or is there a
> more elegant solution for in-kernel mapping of a vmalloc buffer ?

Hi Damien,

I don't think that bio_rq_map_kern() works with vmalloc-ed buffers. How 
about using is_vmalloc_addr() inside scsi_execute_req() to determine 
whether or not the buffer passed to that function has been allocated 
with vmalloc()? There may be other scsi_execute_req() callers that can 
benefit from passing a vmalloc-ed buffer to that function.

Regarding the maximum segment size: is mpt3sas still the most popular 
HBA? Is the maximum segment size 128 for that driver? Is 128 * 4 KB = 
512 KB big enough for the report zones buffer?

Regarding the loop that calls sd_zbc_parse_report(): are you sure that 
that kmap()/kunmap() calls would be necessary in that loop?

Thanks,

Bart.
