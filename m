Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF3AE18650D
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Mar 2020 07:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgCPGfC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 16 Mar 2020 02:35:02 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:37026 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729455AbgCPGfB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 16 Mar 2020 02:35:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584340501; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=OwErceFW23ZNn6eud/cydjRhiFjDFARC1CNzkO9VKPQ=;
 b=w94OkOe6xBHmWWiCNK0Jg9jWgIa/qne4ilK8uX/GsJt2iO6NfAbsFvCPYSnzTckTJEtuQVrn
 7+PRcCbZ7IhTo1oCDYJNAVrSyZnTn8/Bv09JM2bDQozCH3R4tE+0FVCxkpmxbuF/nRuqQfcV
 WAd7s4AFKiyp30tgfK0K1FKNr4E=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6f1e09.7f229e20b3b0-smtp-out-n05;
 Mon, 16 Mar 2020 06:34:49 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6ECA7C44791; Mon, 16 Mar 2020 06:34:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F0662C433D2;
        Mon, 16 Mar 2020 06:34:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Mar 2020 14:34:41 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     linux-scsi@vger.kernel.org, martin.peter~sen@oracle.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com,
        beanhuo@micron.com, asutoshd@codeaurora.org,
        matthias.bgg@gmail.com, bvanassche@acm.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kuohong.wang@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, andy.teng@mediatek.com
Subject: Re: [PATCH v5 7/8] scsi: ufs: make HCE polling more compact to
 improve initialization latency
In-Reply-To: <20200316034218.11914-8-stanley.chu@mediatek.com>
References: <20200316034218.11914-1-stanley.chu@mediatek.com>
 <20200316034218.11914-8-stanley.chu@mediatek.com>
Message-ID: <b25d211adfe0f14c729dbf4e6eb5e159@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-03-16 11:42, Stanley Chu wrote:
> Reduce the waiting period between each HCE (Host Controller Enable)
> polling from 5 ms to 1 ms. In the same time, increase the maximum 
> polling
> times to make "total polling time" unchanged approximately.
> 
> This change could make HCE initializatoin faster to improve latency of
> ufshcd initialization, error recovery, and resume behaviors.
> 
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>

Reviewed-by: Can Guo <cang@codeaurora.org>

> ---
>  drivers/scsi/ufs/ufshcd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index dcbf45d547d8..cd33d07c56cf 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -4301,7 +4301,7 @@ int ufshcd_hba_enable(struct ufs_hba *hba)
>  	ufshcd_wait_us(hba->hba_enable_delay_us, 100, true);
> 
>  	/* wait for the host controller to complete initialization */
> -	retry = 10;
> +	retry = 50;
>  	while (ufshcd_is_hba_active(hba)) {
>  		if (retry) {
>  			retry--;
> @@ -4310,7 +4310,7 @@ int ufshcd_hba_enable(struct ufs_hba *hba)
>  				"Controller enable failed\n");
>  			return -EIO;
>  		}
> -		ufshcd_wait_us(5000, 100, true);
> +		ufshcd_wait_us(1000, 100, true);
>  	}
> 
>  	/* enable UIC related interrupts */
