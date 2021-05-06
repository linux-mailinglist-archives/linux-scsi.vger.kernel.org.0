Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F06C375DB8
	for <lists+linux-scsi@lfdr.de>; Fri,  7 May 2021 01:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbhEFX7L (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 May 2021 19:59:11 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:36919 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbhEFX7I (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 May 2021 19:59:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620345489; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=5U9aNzCjdnh9VR/MceKDiACztq/+idznaGHSdPZ1p0w=;
 b=xRz66cf1ugD2oLEaV5fgkwVZVSwa0tZEFd5YDrZ8U94jDXbajVSwaXq3jGtu6IqX8/st+aMw
 MWRolSXjXZKUXrfGSzyrcGCsqEatxOt/j2c7UQYSIyVuF1x/EDdmDtMFC+v9LBeJ7zwubWXQ
 zI0iVm9tTZdzae7eepsRpDQUaSg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6094826c9a9ff96d959b8904 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 06 May 2021 23:57:32
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D8563C43145; Thu,  6 May 2021 23:57:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B0F63C433D3;
        Thu,  6 May 2021 23:57:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 07 May 2021 07:57:31 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Don Brace <don.brace@microchip.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Asutosh Das <asutoshd@codeaurora.org>
Subject: Re: [PATCH 098/117] ufs: Remove an unused structure member
In-Reply-To: <20210420021402.27678-8-bvanassche@acm.org>
References: <20210420000845.25873-1-bvanassche@acm.org>
 <20210420021402.27678-8-bvanassche@acm.org>
Message-ID: <8617407697e19417849d1c6e86134fe1@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2021-04-20 10:13, Bart Van Assche wrote:
> The 'scsi_status' member is present since the introduction of the UFS
> driver but has never been used. Hence remove it.
> 
> Cc: Can Guo <cang@codeaurora.org>
> Cc: Avri Altman <avri.altman@wdc.com>
> Cc: Bean Huo <beanhuo@micron.com>
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: Asutosh Das <asutoshd@codeaurora.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/scsi/ufs/ufshcd.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index 5eb66a8debc7..20ad78083246 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -211,7 +211,6 @@ struct ufshcd_lrb {
>  	struct scsi_cmnd *cmd;
>  	u8 *sense_buffer;
>  	unsigned int sense_bufflen;
> -	int scsi_status;
> 
>  	int command_type;
>  	int task_tag;

Reviewed-by: Can Guo <cang@codeaurora.org>
