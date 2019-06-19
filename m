Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36FE34C275
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Jun 2019 22:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbfFSUgE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 19 Jun 2019 16:36:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40963 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFSUgE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 19 Jun 2019 16:36:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id y72so289037pgd.8
        for <linux-scsi@vger.kernel.org>; Wed, 19 Jun 2019 13:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C6OJh8t7WPwWhJTvBEBlYS/LT/yNq/MJyxHwvRpnWXQ=;
        b=T9kMGO+hXvdd3X1LXfmXpM8+G92HB7m5Ohd9s9WBMppUjepMabFr3nS99QuqwiZ1OD
         Lvcr3zWminzBTzJUOAE60T6m431GhhhYryZ8eGg67EYdfy33W6R81OowD8cb9F6PP9Bg
         1Nkoeq7aZ+crV8v8MXZOOxgtVy1289QzknzjY6JBH90bmCPsPg32RGaFsPdC+dOm51HJ
         M0BkedfdYztYkmiTHbEZSM0lijvudVWZWsEiLa+Ir2SXuDV6yjr9+6l67428fgpK+tMH
         uR3x1eWnJHo/GcohaDNtj2WQnP+lBW8CHI09+QowaIWcTTWt2lJuCol7yuwWZQDisw71
         sxNg==
X-Gm-Message-State: APjAAAViRul2LSh/6K7Ix5JhZbjy4LniklQN5jjN+WipE7sFyBqm1Wu0
        ylnwJDqhFsxYkPw7ZKkWZgtdgCysUc0=
X-Google-Smtp-Source: APXvYqxxTdBzWGYH1Bjjp/pB/H8v2xojzKu9Ju2SwSbpEYsdi170WhqOrxKh0yQBZmpOiqH4uyRzjA==
X-Received: by 2002:a17:90a:372a:: with SMTP id u39mr13258734pjb.2.1560976563684;
        Wed, 19 Jun 2019 13:36:03 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id x128sm22545915pfd.17.2019.06.19.13.36.02
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 13:36:02 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] qla2xxx: Fix NVME cmd and LS cmd timeout race
 condition
To:     Himanshu Madhani <hmadhani@marvell.com>,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org
References: <20190618181021.16547-1-hmadhani@marvell.com>
 <20190618181021.16547-4-hmadhani@marvell.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <018503da-f39c-1583-87b3-af2b632432b5@acm.org>
Date:   Wed, 19 Jun 2019 13:36:01 -0700
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
> diff --git a/drivers/scsi/qla2xxx/qla_nvme.h b/drivers/scsi/qla2xxx/qla_nvme.h
> index 2d088add7011..67bb4a2a3742 100644
> --- a/drivers/scsi/qla2xxx/qla_nvme.h
> +++ b/drivers/scsi/qla2xxx/qla_nvme.h
> @@ -34,6 +34,7 @@ struct nvme_private {
>   	struct work_struct ls_work;
>   	struct work_struct abort_work;
>   	int comp_status;
> +	spinlock_t cmd_lock;
>   };

Hi Himanshu and Quinn,

 From the qla2xxx driver:

static struct nvme_fc_port_template qla_nvme_fc_transport = {
	[ ... ]
	.lsrqst_priv_sz = sizeof(struct nvme_private),
	.fcprqst_priv_sz = sizeof(struct nvme_private),
};
[ ... ]
struct nvme_private {
	struct srb	*sp;
	struct nvmefc_ls_req *fd;
	struct work_struct ls_work;
	struct work_struct abort_work;
	int comp_status;
};

Has it been considered to change "struct srb *sp" into "struct srb srb"? 
That would guarantee that the srb and nvme_private data structures have 
the same lifetime. As a result using the srb reference count would no 
longer be necessary for NVMe and no new locking would have to be 
introduced in the NVMe-FC completion paths.

I think a similar approach is possible for the SCSI-FC code.

Does this make sense to you?

Thanks,

Bart.
