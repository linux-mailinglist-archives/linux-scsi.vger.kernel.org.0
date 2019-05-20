Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4FE422B81
	for <lists+linux-scsi@lfdr.de>; Mon, 20 May 2019 07:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbfETF55 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 May 2019 01:57:57 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:29100 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfETF54 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 May 2019 01:57:56 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190520055752epoutp01f376629bfdb1e045267244dad3e1df2c~gTpUAUX3T1693616936epoutp01i
        for <linux-scsi@vger.kernel.org>; Mon, 20 May 2019 05:57:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190520055752epoutp01f376629bfdb1e045267244dad3e1df2c~gTpUAUX3T1693616936epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558331872;
        bh=pf/KCy+GO7rtk65SYPTQ1vHyG8/rySW/xBgOPJ/BZwo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=t5/usAV0VCepPoEB7bmUt3f7AYXNqFabIDddgGFu6JsjDztKdeFYyS1tyS8g7NfaT
         H8OcYX1n5nwngqzc0oYfVZ6UGuaw/rU2gU5u1L8nL5p1sDodUDhe09YSIDEXcaTb8p
         HmJOlRUgI4StN2p1AbW8LAuyiEYLSrwca3AiTKq8=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20190520055752epcas5p1029c17d6a29b285748aaf66f51d93b37~gTpTjxBzk1988619886epcas5p1r;
        Mon, 20 May 2019 05:57:52 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.36.04066.0E142EC5; Mon, 20 May 2019 14:57:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20190520055751epcas5p1e10f8b114846171f886bd0c8ecbe6c9b~gTpS60hGe2528725287epcas5p1D;
        Mon, 20 May 2019 05:57:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190520055751epsmtrp2d30ba8a4e1c26157031ffa7edf70c9dd~gTpS502Y81381713817epsmtrp2Q;
        Mon, 20 May 2019 05:57:51 +0000 (GMT)
X-AuditID: b6c32a4a-973ff70000000fe2-74-5ce241e04e6d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.00.03692.FD142EC5; Mon, 20 May 2019 14:57:51 +0900 (KST)
Received: from [107.108.73.28] (unknown [107.108.73.28]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190520055749epsmtip19e97851e4d461fc9d6e39bcc8c632f0c~gTpQ38sWF0674606746epsmtip1B;
        Mon, 20 May 2019 05:57:49 +0000 (GMT)
Subject: Re: [PATCH v2 2/3] scsi: ufs: Add error-handling of Auto-Hibernate
To:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, avri.altman@wdc.com,
        pedrom.sousa@synopsys.com
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        evgreen@chromium.org, beanhuo@micron.com, marc.w.gonzalez@free.fr,
        kuohong.wang@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, andy.teng@mediatek.com
From:   Alim Akhtar <alim.akhtar@samsung.com>
Message-ID: <c8c03a4c-3131-9036-02ce-8678c2113398@samsung.com>
Date:   Mon, 20 May 2019 11:07:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557912988-26758-3-git-send-email-stanley.chu@mediatek.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzH9/093P3uuPo6WR8x6WhUI1Tbj8jDkp+HNX+a3aabftKuq3OX
        CJvogbpQZlqnZK1CrEjXMyV0xbCbTqtG4gxNpc5zD3T3O9N/r+/n/f5835/Pd1+GlA/SXkxs
        fCKvi1fFKURSquaBn/+yNxvfKleYc73YJ5etJPvpl1XE3u/PpNjyz3UiNr0vj2DT/wyQbNW7
        lzT7ItWCWEPXlFBjf0qyV82TBHsyLYhNa/tGsabRMZotNXWjDe7cpRQLxZ2rsNNcvfGVmLtT
        cpxL62imuB+Vp0XcyPseiqtutiPOXrWAO9ViIHZKd0vXRvNxsUm8LjAsSrrffPER0j5bdLjh
        5xCZgtrnZyEJAzgYyorGxVlIyshxI4JftkJSOIwiqO0wupTvCBr7C+h/Lem3+50sx3cRmMaT
        BNMggu7iHJFDmI23g6lxhHAIHvgCguFJk/NeEl8kYKShl3K4RDgAXuVVEw6W4TA4294ldjCF
        feFb0YDTMwfvgr62W7TgmQUd+TZnXYK3QobF4GQSe0KPrYgQ2BtqBwucYYDviSGts8Q1dzgU
        ZzaKBZ4NA+ZqF3uBfeju1NjMFKshuyFIKB+D0sttlMDroaWzgHJYSOwHlQ2BQpQbnBmzEUKn
        DE5nyAW3L6QOWV2d8yDXYHANwMHEtVzXi/YiuGGtp3LQQuO0zYzTtjFO28b4P/kKosrRXF6r
        18Tw+hDtqnj+0HK9SqM/GB+zfG+Cpgo5P6H/tjpU9mxHK8IMUsyUfbnQr5TTqiR9sqYVAUMq
        PGRBS/qUclm0KvkIr0vYozsYx+tb0TyGUnjKztNWpRzHqBJ5Nc9red0/lWAkXinIc8jSNMO8
        LIL4EEF7R1Z2nXUrkxeGqh52nnKDynz3yYmY578DYoffb9m8qSL46KrHkWr2R3agOne1pCU7
        9KNEnRN+QnLgtX3JHD+faP/yiRUhPiKL4kGGvfBd4p0EsTu6mRzb9bBWY9Bm1HwNxouDOi+t
        iVramn299+e+1MzMdU0KSr9ftdKf1OlVfwFqXntYgAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsWy7bCSnO59x0cxBufualqcnneV2eLlz6ts
        FgcfdrJYrHqzg82i9f50JovW/6+YLTY9vsZqcbn5IqNF93WgxLbPZ5ktlh//x2TR1GJs0XLs
        K4vF1k+/WS2Wbr3J6MDvMbvhIotH/7rPrB47Z91l99i8pN6j5eR+Fo/v6zvYPD4+vcXisWX/
        Z0aPz5vkPNoPdDMFcEVx2aSk5mSWpRbp2yVwZRyfdpSx4Jxyxa4f75gbGE/IdDFyckgImEi0
        bnzI2sXIxSEksJtRoun/MxaIhLTE9Y0T2CFsYYmV/56zQxS9ZpSYt6+DESQhLOAtsXX3RyaQ
        hIjAFEaJvasegjnMAlOYJDY+38AM0XKbUeL5+R1gc9kEtCXuTt/CBGLzCthJ9J24DraDRUBV
        4uv8V2A1ogIREmfer2CBqBGUODnzCZjNKeAp0XaxG8xmFjCTmLf5ITOELS5x68l8JghbXmL7
        2znMExiFZiFpn4WkZRaSlllIWhYwsqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiO
        XS3NHYyXl8QfYhTgYFTi4fWY/jBGiDWxrLgy9xCjBAezkgivsfr9GCHelMTKqtSi/Pii0pzU
        4kOM0hwsSuK8T/OORQoJpCeWpGanphakFsFkmTg4pRoYxV73fNlhWR28IkDMuT788ooz+XGy
        HCu395ve6wm6P1GRoXSf2Lzm7I7OfX6LW+5dqVjwedO9nC2ql09u3yebOHXBrdOONdmzy5fa
        a1vN7jgbr/f8lMwS91OckgIvlv1nf18jf+35mbyIm+HvdbOO+ilY5zaLzL45u+xazyu/WvH7
        F9UKq76uVWIpzkg01GIuKk4EAEp+ZfTZAgAA
X-CMS-MailID: 20190520055751epcas5p1e10f8b114846171f886bd0c8ecbe6c9b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20190515093655epcas1p4642d3521d2abf9909c6964eea248540c
References: <1557912988-26758-1-git-send-email-stanley.chu@mediatek.com>
        <CGME20190515093655epcas1p4642d3521d2abf9909c6964eea248540c@epcas1p4.samsung.com>
        <1557912988-26758-3-git-send-email-stanley.chu@mediatek.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Stanley,

On 5/15/19 3:06 PM, Stanley Chu wrote:
> Currently auto-hibernate is activated if host supports
> auto-hibern8 capability. However error-handling is not implemented,
> which makes the feature somewhat risky.
> 
> If either "Hibernate Enter" or "Hibernate Exit" fail during
> auto-hibernate flow, the corresponding interrupt
> "UIC_HIBERNATE_ENTER" or "UIC_HIBERNATE_EXIT" shall be raised
> according to UFS specification.
> 
> This patch adds auto-hibernate error-handling:
> 
> - Monitor "Hibernate Enter" and "Hibernate Exit" interrupts after
>    auto-hibernate feature is activated.
> 
> - If fail happens, trigger error-handling just like "manual-hibernate"
>    fail and apply the same recovery flow: schedule UFS error handler in
>    ufshcd_check_errors(), and then do host reset and restore
>    in UFS error handler.
> 
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
>   drivers/scsi/ufs/ufshcd.c | 31 +++++++++++++++++++++++++++++++
>   drivers/scsi/ufs/ufshcd.h |  5 +++++
>   drivers/scsi/ufs/ufshci.h |  3 +++
>   3 files changed, 39 insertions(+)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 1665820c22fd..e6a86223a0d4 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -5254,6 +5254,7 @@ static void ufshcd_err_handler(struct work_struct *work)
>   			goto skip_err_handling;
>   	}
>   	if ((hba->saved_err & INT_FATAL_ERRORS) ||
> +	    (hba->saved_err & UFSHCD_UIC_AH8_ERROR_MASK) ||
>   	    ((hba->saved_err & UIC_ERROR) &&
>   	    (hba->saved_uic_err & (UFSHCD_UIC_DL_PA_INIT_ERROR |
>   				   UFSHCD_UIC_DL_NAC_RECEIVED_ERROR |
> @@ -5413,6 +5414,23 @@ static void ufshcd_update_uic_error(struct ufs_hba *hba)
>   			__func__, hba->uic_error);
>   }
>   
> +static bool ufshcd_is_auto_hibern8_error(struct ufs_hba *hba,
> +					 u32 intr_mask)
> +{
> +	if (!ufshcd_is_auto_hibern8_supported(hba))
> +		return false;
> +
> +	if (!(intr_mask & UFSHCD_UIC_AH8_ERROR_MASK))
> +		return false;
> +
> +	if (hba->active_uic_cmd &&
> +	    (hba->active_uic_cmd->command == UIC_CMD_DME_HIBER_ENTER ||
> +	    hba->active_uic_cmd->command == UIC_CMD_DME_HIBER_EXIT))
> +		return false;
> +
> +	return true;
> +}
> +
>   /**
>    * ufshcd_check_errors - Check for errors that need s/w attention
>    * @hba: per-adapter instance
> @@ -5431,6 +5449,15 @@ static void ufshcd_check_errors(struct ufs_hba *hba)
>   			queue_eh_work = true;
>   	}
>   
> +	if (hba->errors & UFSHCD_UIC_AH8_ERROR_MASK) {
> +		dev_err(hba->dev,
> +			"%s: Auto Hibern8 %s failed - status: 0x%08x, upmcrs: 0x%08x\n",
> +			__func__, (hba->errors & UIC_HIBERNATE_ENTER) ?
> +			"Enter" : "Exit",
> +			hba->errors, ufshcd_get_upmcrs(hba));
> +		queue_eh_work = true;
> +	}
> +
>   	if (queue_eh_work) {
>   		/*
>   		 * update the transfer error masks to sticky bits, let's do this
> @@ -5493,6 +5520,10 @@ static void ufshcd_tmc_handler(struct ufs_hba *hba)
>   static void ufshcd_sl_intr(struct ufs_hba *hba, u32 intr_status)
>   {
>   	hba->errors = UFSHCD_ERROR_MASK & intr_status;
> +
> +	if (ufshcd_is_auto_hibern8_error(hba, intr_status))
> +		hba->errors |= (UFSHCD_UIC_AH8_ERROR_MASK & intr_status);
> +
>   	if (hba->errors)
>   		ufshcd_check_errors(hba);
>   
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index ecfa898b9ccc..994d73d03207 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -740,6 +740,11 @@ return true;
>   #endif
>   }
>   
> +static inline bool ufshcd_is_auto_hibern8_supported(struct ufs_hba *hba)
> +{
> +	return (hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT);
> +}
> +
>   #define ufshcd_writel(hba, val, reg)	\
>   	writel((val), (hba)->mmio_base + (reg))
>   #define ufshcd_readl(hba, reg)	\
> diff --git a/drivers/scsi/ufs/ufshci.h b/drivers/scsi/ufs/ufshci.h
> index 6fa889de5ee5..4bcb205f2077 100644
> --- a/drivers/scsi/ufs/ufshci.h
> +++ b/drivers/scsi/ufs/ufshci.h
> @@ -148,6 +148,9 @@ enum {
>   				UIC_HIBERNATE_EXIT |\
>   				UIC_POWER_MODE)
>   
> +#define UFSHCD_UIC_AH8_ERROR_MASK	(UIC_HIBERNATE_ENTER |\
> +					UIC_HIBERNATE_EXIT)
> +
>   #define UFSHCD_UIC_MASK		(UIC_COMMAND_COMPL | UFSHCD_UIC_PWR_MASK)
>   
>   #define UFSHCD_ERROR_MASK	(UIC_ERROR |\
> 
I don't have a way to test this patch, as my current platform does not 
support Auto Hibern8, over all this look ok to me.
Thanks,
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
