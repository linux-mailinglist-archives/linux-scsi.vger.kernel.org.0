Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DA3231921
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Jul 2020 07:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgG2Fb5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 Jul 2020 01:31:57 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:56303 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgG2Fb5 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 Jul 2020 01:31:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596000717; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=msx+gBK9mgOBcKEpu5rUP0WumjhIp0LNn0i9vsL3Tdc=;
 b=FDduC6LRPX2Ym+fMP3+GbhH7U8TfaAZ+6GXVdbiisHIgIcJB9bG+Z6H95K/rbEojY9eF+FpM
 1ahp/C0ur1mVTjWJA22R5qNv1thrPjhPATwsM1dlKY0Jfyat2hLg1CBitGh0b93IYiSagw8T
 AQ4+0XNa3VuFLRBp+///2u6Tm0c=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f2109befcbecb3df1cb1156 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 29 Jul 2020 05:31:42
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 57325C433A0; Wed, 29 Jul 2020 05:31:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A649C433C6;
        Wed, 29 Jul 2020 05:31:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Jul 2020 13:31:40 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com,
        beanhuo@micron.com, asutoshd@codeaurora.org,
        matthias.bgg@gmail.com, bvanassche@acm.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kuohong.wang@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, andy.teng@mediatek.com,
        chaotian.jing@mediatek.com, cc.chou@mediatek.com
Subject: Re: [PATCH v1 1/2] scsi: ufs: Introduce device quirk
 "DELAY_AFTER_LPM"
In-Reply-To: <20200729051840.31318-2-stanley.chu@mediatek.com>
References: <20200729051840.31318-1-stanley.chu@mediatek.com>
 <20200729051840.31318-2-stanley.chu@mediatek.com>
Message-ID: <b859b49f4b5e85b81a24735a53f5aa4e@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Stanley,

On 2020-07-29 13:18, Stanley Chu wrote:
> Some UFS devices require delay after VCC power rail is turned-off.
> Introduce a device quirk "DELAY_AFTER_LPM" to add 5ms delays after
> VCC power-off during suspend flow.
> 

Just curious, I can understand if you want to add some delays before
turnning off VCC/VCCQ/VCCQ2, but what is the delay AFTER turnning
them off for? I mean the power has been cut by host from PMIC, how
can the delay benefit the UFS device?

Thanks,

Can Guo.

> Signed-off-by: Andy Teng <andy.teng@mediatek.com>
> Signed-off-by: Peter Wang <peter.wang@mediatek.com>
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
>  drivers/scsi/ufs/ufs_quirks.h |  7 +++++++
>  drivers/scsi/ufs/ufshcd.c     | 11 +++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/scsi/ufs/ufs_quirks.h 
> b/drivers/scsi/ufs/ufs_quirks.h
> index 2a0041493e30..07f559ac5883 100644
> --- a/drivers/scsi/ufs/ufs_quirks.h
> +++ b/drivers/scsi/ufs/ufs_quirks.h
> @@ -109,4 +109,11 @@ struct ufs_dev_fix {
>   */
>  #define UFS_DEVICE_QUIRK_SUPPORT_EXTENDED_FEATURES (1 << 10)
> 
> +/*
> + * Some UFS devices require delay after VCC power rail is turned-off.
> + * Enable this quirk to introduce 5ms delays after VCC power-off 
> during
> + * suspend flow.
> + */
> +#define UFS_DEVICE_QUIRK_DELAY_AFTER_LPM        (1 << 11)
> +
>  #endif /* UFS_QUIRKS_H_ */
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index acba2271c5d3..63f4e2f75aa1 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -8111,6 +8111,8 @@ static int ufshcd_link_state_transition(struct
> ufs_hba *hba,
> 
>  static void ufshcd_vreg_set_lpm(struct ufs_hba *hba)
>  {
> +	bool vcc_off = false;
> +
>  	/*
>  	 * It seems some UFS devices may keep drawing more than sleep current
>  	 * (atleast for 500us) from UFS rails (especially from VCCQ rail).
> @@ -8139,13 +8141,22 @@ static void ufshcd_vreg_set_lpm(struct ufs_hba 
> *hba)
>  	if (ufshcd_is_ufs_dev_poweroff(hba) && ufshcd_is_link_off(hba) &&
>  	    !hba->dev_info.is_lu_power_on_wp) {
>  		ufshcd_setup_vreg(hba, false);
> +		vcc_off = true;
>  	} else if (!ufshcd_is_ufs_dev_active(hba)) {
>  		ufshcd_toggle_vreg(hba->dev, hba->vreg_info.vcc, false);
> +		vcc_off = true;
>  		if (!ufshcd_is_link_active(hba)) {
>  			ufshcd_config_vreg_lpm(hba, hba->vreg_info.vccq);
>  			ufshcd_config_vreg_lpm(hba, hba->vreg_info.vccq2);
>  		}
>  	}
> +
> +	/*
> +	 * Some UFS devices require delay after VCC power rail is turned-off.
> +	 */
> +	if (vcc_off && hba->vreg_info.vcc &&
> +		hba->dev_quirks & UFS_DEVICE_QUIRK_DELAY_AFTER_LPM)
> +		usleep_range(5000, 5100);
>  }
> 
>  static int ufshcd_vreg_set_hpm(struct ufs_hba *hba)
