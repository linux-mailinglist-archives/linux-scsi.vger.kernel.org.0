Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98F934AB32
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 21:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbfFRTtZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 15:49:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46078 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbfFRTtY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 15:49:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so8244843pfq.12
        for <linux-scsi@vger.kernel.org>; Tue, 18 Jun 2019 12:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a0eH3duDf3iRm1d+2txgYEfezVl8hZtXdHrct9Cop/g=;
        b=d3BvjFQm3Q6e/TdSZqH2TKplwJZ0yBFcPX0bWgWV6QIMtA/hW3oGzBeJShPli5M2fC
         m2sIbjcqgdLeNFgkFDZjX79+C7e9ozNLls+JYjn+7BCSaD+VWlFLnUg7SWtTS3iwzCEo
         OyVDZJ5OxkScwNuB6Ucb2I1JJgOsAQ+6WuePIulOuHGiT/4duHtjLqDiufm+19CIRUIQ
         vNOk0YI/ftJ63iNa01HUrML9C5jmQpyKOT2DQn6w+4+qTFXy7IeA9p+ZV7YaPlnyqHbM
         ALgZlM9gyfDFCy8yX+p803gulXryWvcsNtqXqGz6ZFAbLBQ9tJLDf8vMy7X6sPlbB/Bt
         RO4w==
X-Gm-Message-State: APjAAAVqZFr7rvdDkhJyiOuxMHs7Uip01Hw4UsFTizuO7ZJDEWaIQK4S
        850vYlCxTifTO1teNwgb/6GFNVv3usw=
X-Google-Smtp-Source: APXvYqyHesbwdFzQwDw5dMpFW7uch/0b7ONy4lP5ORcnvGFcgn7KhpouPRm0lpLuc0PGpU/bF7eWKA==
X-Received: by 2002:a63:6ec1:: with SMTP id j184mr4242711pgc.225.1560887363538;
        Tue, 18 Jun 2019 12:49:23 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id w22sm1863905pfi.175.2019.06.18.12.49.22
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 12:49:22 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] qla2xxx: Fix NVME cmd and LS cmd timeout race
 condition
To:     Himanshu Madhani <hmadhani@marvell.com>,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org
References: <20190618181021.16547-1-hmadhani@marvell.com>
 <20190618181021.16547-4-hmadhani@marvell.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <72f94746-5d2a-321f-04f2-c8ad30f0bd3c@acm.org>
Date:   Tue, 18 Jun 2019 12:49:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618181021.16547-4-hmadhani@marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/18/19 11:10 AM, Himanshu Madhani wrote:
> +out:
> +	/* kref_get was done before work was schedule. */
> +	if (sp->type == SRB_NVME_CMD)
> +		kref_put(&sp->cmd_kref, qla_nvme_release_fcp_cmd_kref);
> +	else if (sp->type == SRB_NVME_LS)
> +		kref_put(&sp->cmd_kref, qla_nvme_release_ls_cmd_kref);

Hi Himanshu and Quinn,

The above code looks ugly to me. I would prefer that the 
qla_nvme_release_fcp_cmd_kref() and qla_nvme_release_ls_cmd_kref() are 
consolidated into a single function such that the above code can be 
changed into a single kref_put() call.

Additionally, I think this patch introduces a behavior change. Today if 
a completion and abort request race, the NVMe command is completed. I 
think this patch changes that behavior into failing the NVMe command 
with status "aborted". That behavior change has not been described in 
the commit message. That makes me wonder whether that behavior change is 
unintentional?

Thanks,

Bart.


