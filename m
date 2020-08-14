Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D592446FE
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Aug 2020 11:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgHNJ3J (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 Aug 2020 05:29:09 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:38775 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726606AbgHNJ3H (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 14 Aug 2020 05:29:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597397347; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=brCGegxfCcnWHvjZPGGWO7kpAheoszRzrzBQ4JAl0Jo=;
 b=rHa7wEnB3Za0AjIJ+zzOP9j27poaBWq4/Yohsdq6Kvcg8b6SrcrU2DKyYd2bTbbrkTo/XJHm
 ofix0JWc78wJoUQSgKDtznPN9a4eyLO8H5MXGthpY0Kl3qW/LFyrJSnJ9jw+0S7v+TDBS2pK
 ZgGqJwMFLRep5ZCsRlMhQChLfXY=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f365961d96d28d61e1c6443 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 09:29:05
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DFD67C433CB; Fri, 14 Aug 2020 09:29:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 16B07C433C6;
        Fri, 14 Aug 2020 09:29:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Aug 2020 17:29:04 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Asutosh Das <asutoshd@codeaurora.org>
Cc:     Bean Huo <huobean@gmail.com>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] scsi: ufs: change ufshcd_comp_devman_upiu() to
 ufshcd_compose_devman_upiu()
In-Reply-To: <20200813155515.GB25655@asutoshd-linux1.qualcomm.com>
References: <20200812143704.30245-1-huobean@gmail.com>
 <20200812143704.30245-2-huobean@gmail.com>
 <20200813155515.GB25655@asutoshd-linux1.qualcomm.com>
Message-ID: <f4a9c3a1147bb03a876d541d1e637976@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-08-13 23:55, Asutosh Das wrote:
> On Wed, Aug 12 2020 at 07:37 -0700, Bean Huo wrote:
>> From: Bean Huo <beanhuo@micron.com>
>> 
>> ufshcd_comp_devman_upiu() alwasy make me confuse that it is a request
>> completion calling function. Change it to 
>> ufshcd_compose_devman_upiu().
>> 
>> Signed-off-by: Bean Huo <beanhuo@micron.com>
>> Acked-by: Avri Altman <avri.altman@wdc.com>
> 
> Reviewed-by: Asutosh Das <asutoshd@codeaurora.org>

Reviewed-by: Can Guo <cang@codeaurora.org>

> 
>> ---
>> drivers/scsi/ufs/ufshcd.c | 7 ++++---
>> 1 file changed, 4 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> index 5f09cda7b21c..e3663b85e8ee 100644
>> --- a/drivers/scsi/ufs/ufshcd.c
>> +++ b/drivers/scsi/ufs/ufshcd.c
>> @@ -2391,12 +2391,13 @@ static inline void 
>> ufshcd_prepare_utp_nop_upiu(struct ufshcd_lrb *lrbp)
>> }
>> 
>> /**
>> - * ufshcd_comp_devman_upiu - UFS Protocol Information Unit(UPIU)
>> + * ufshcd_compose_devman_upiu - UFS Protocol Information Unit(UPIU)
>>  *			     for Device Management Purposes
>>  * @hba: per adapter instance
>>  * @lrbp: pointer to local reference block
>>  */
>> -static int ufshcd_comp_devman_upiu(struct ufs_hba *hba, struct 
>> ufshcd_lrb *lrbp)
>> +static int ufshcd_compose_devman_upiu(struct ufs_hba *hba,
>> +				      struct ufshcd_lrb *lrbp)
>> {
>> 	u8 upiu_flags;
>> 	int ret = 0;
>> @@ -2590,7 +2591,7 @@ static int ufshcd_compose_dev_cmd(struct ufs_hba 
>> *hba,
>> 	ufshcd_prepare_lrbp_crypto(NULL, lrbp);
>> 	hba->dev_cmd.type = cmd_type;
>> 
>> -	return ufshcd_comp_devman_upiu(hba, lrbp);
>> +	return ufshcd_compose_devman_upiu(hba, lrbp);
>> }
>> 
>> static int
>> -- 2.17.1
>> 
