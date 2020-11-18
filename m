Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3913D2B7397
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Nov 2020 02:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbgKRBLp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Nov 2020 20:11:45 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:44861 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbgKRBLo (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 17 Nov 2020 20:11:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605661903; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=AdSCJkjqb9OkQUTrN7lTj6Tme9Iyj9rtBA9UFQ9zHss=;
 b=NGFDegXLv7EuTrpqWnx+pLAYvDzuJ/eJ4wQfot33gkURjV5DO/kG8uLujuWSfcomatIQr1fv
 Sc/bG6RPc/5H0XSZqTwZndwQK1rq2cIYoYTiu7K4vB+9hVbcDQzWSiJWRRRd0beUk/6pNK/g
 wfDVB80XoJkDb2Sg7CuJ8PahwRA=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5fb474b96c42d983b9048c65 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 18 Nov 2020 01:11:21
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 83FD8C43467; Wed, 18 Nov 2020 01:11:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 29EADC433ED;
        Wed, 18 Nov 2020 01:11:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Nov 2020 09:11:19 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        Leo Liou <leoliou@google.com>
Subject: Re: [PATCH v5 7/7] scsi: ufs: show lba and length for unmap commands
In-Reply-To: <20201117165839.1643377-8-jaegeuk@kernel.org>
References: <20201117165839.1643377-1-jaegeuk@kernel.org>
 <20201117165839.1643377-8-jaegeuk@kernel.org>
Message-ID: <173677d39200bbdf577fb7923eef2916@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-11-18 00:58, Jaegeuk Kim wrote:
> From: Leo Liou <leoliou@google.com>
> 
> We have lba and length for unmap commands.
> 
> Signed-off-by: Leo Liou <leoliou@google.com>
> Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Can Guo <cang@codeaurora.org>

> ---
>  drivers/scsi/ufs/ufshcd.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 86c8dee01ca9..dba3ee307307 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -376,6 +376,11 @@ static void ufshcd_add_command_trace(struct 
> ufs_hba *hba,
>  				lrbp->ucd_req_ptr->sc.exp_data_transfer_len);
>  			if (opcode == WRITE_10)
>  				group_id = lrbp->cmd->cmnd[6];
> +		} else if (opcode == UNMAP) {
> +			if (cmd->request) {
> +				lba = scsi_get_lba(cmd);
> +				transfer_len = blk_rq_bytes(cmd->request);
> +			}
>  		}
>  	}
