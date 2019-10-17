Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF13DB2D2
	for <lists+linux-scsi@lfdr.de>; Thu, 17 Oct 2019 18:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440502AbfJQQwP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Oct 2019 12:52:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54452 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394354AbfJQQwP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 17 Oct 2019 12:52:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so3280757wmp.4
        for <linux-scsi@vger.kernel.org>; Thu, 17 Oct 2019 09:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=qWuICkJxlAzSjtE7G+WhKe86Y6VcVIm+PEznLLcOOiM=;
        b=EROi2PtLwp+mUOQ7/b5/bH4ezES71y9xqthcw7UzTQcMRgM0S6trltPbA1fcSliUf3
         5btzuAQCP3DzqgfQH0Tl0vIP2guMiQA4OlzWyYzSK08hGPAiq4PcH9skiOL0QqA1VJfX
         JOFTLeK0WtLGCv0HFCsokdb5mxCQl/2vSNx1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qWuICkJxlAzSjtE7G+WhKe86Y6VcVIm+PEznLLcOOiM=;
        b=fRK364Q9ngiqgXx9cESfd513xdQTzDE4DV12b4t+3EQtqz9dg9dPFhdXcqsuRSdTqs
         5fMQveNHmsMhqJz+tlgezYm3EBx4/sQrG0ZagzVh0O31Z0ZryZppMmemxdvm9A6Jknta
         z05dBYA6NUyLAWZ/BcVb7n6ldX1430eoUNG0cFLaWOpW+EBb05usJdR8UPg/sgIM1xUY
         Jn/ITTJkzgE2Q/c/MLQb++9I6Bi8sTSNEw1cYlGPg4Frt/uQIAGROp15RlTZaVsMgEKv
         MstKEcVnVnfN7Ag64ic9pfS3K30PEq72FWDOxBg27wSnCwLN6ziVTc6/nFGFsqt4tygU
         S+dg==
X-Gm-Message-State: APjAAAX2YxMn7UfU7YUAgWxffWXmegPDrNaPlIg+ocoMY1XljQL8B5Il
        9VuieKVMvL75rQqBk14OwH2LqZ7zPAo=
X-Google-Smtp-Source: APXvYqweOr1AtWDwUnzcM3TxMwFWPKEnv+UqLqbjaA0CIc/to5ream46xZz1IUna5z5VgItIcYfKTA==
X-Received: by 2002:a1c:1bc5:: with SMTP id b188mr3922677wmb.88.1571331133334;
        Thu, 17 Oct 2019 09:52:13 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t123sm3376702wma.40.2019.10.17.09.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 09:52:11 -0700 (PDT)
Subject: Re: [PATCH] lpfc: remove left-over BUILD_NVME defines
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org,
        Martin George <martin.george@netapp.com>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Hannes Reinecke <hare@suse.com>
References: <20191017150019.75769-1-hare@suse.de>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <28a3dd70-9507-3838-6470-a3069bf2880d@broadcom.com>
Date:   Thu, 17 Oct 2019 09:52:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017150019.75769-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 10/17/2019 8:00 AM, Hannes Reinecke wrote:
> The BUILD_NVME define never got defined anywhere, causing
> NVMe commands to be treated as SCSI commands when freeing
> the buffers.
> This was causing a stuck discovery and a horrible crash
> in lpfc_set_rrq_active() later on.
>
> Fixes: c00f62e6c546 ("scsi: lpfc: Merge per-protocol WQ/CQ pairs into single per-cpu pair")
>
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>   drivers/scsi/lpfc/lpfc_init.c | 2 --
>   drivers/scsi/lpfc/lpfc_scsi.c | 2 --
>   2 files changed, 4 deletions(-)
>
>

Yep. Thanks.

Reviewed-by: James Smart <james.smart@broadcom.com>

-- james


