Return-Path: <linux-scsi+bounces-801-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6394A80C90D
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Dec 2023 13:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA790B20F94
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Dec 2023 12:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F6638FAE;
	Mon, 11 Dec 2023 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oy9iMmt0"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FE238F95
	for <linux-scsi@vger.kernel.org>; Mon, 11 Dec 2023 12:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32DBC433C8;
	Mon, 11 Dec 2023 12:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702296564;
	bh=oXGVbWxA+RKsDk61lpmfn/EL74ws8mWFBZg2YiERZeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oy9iMmt04/8YlHXAxP5bposxknJjP9Ec9FeVST5odYQcm/um+aTXs8W1AatLB/M6d
	 M7W8Dxjq0Ub2OV7hr7bpCyp/wyroXpJJvuS5kXY15X//Frw62DtdyNJ1OohdtD80n1
	 YqSZ4u9/ymEVr8qh3371o8yqUBOxnV/FmIyZCpJIRvMAbzOJNlv/MOehU82UnOkati
	 9MdvFxeAehePjWW5YMemlV5ysLuOCJ6zlrFajB5xpE13sojb2DExCFeijp6kACVHoY
	 W5BahICi1SrYQH3lL+fkHnK13Frl9etjxVHsFH5eDX8WFs8LAGV9iakzr817GPxdPb
	 LYRpseJVDPxNQ==
Date: Mon, 11 Dec 2023 17:39:08 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bean Huo <beanhuo@iokpp.de>
Cc: avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
	beanhuo@micron.com, thomas@t-8ch.de, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, mikebi@micron.com, lporzio@micron.com
Subject: Re: [PATCH v4 2/3] scsi: ufs: core: Add UFS RTC support
Message-ID: <20231211120908.GC2894@thinkpad>
References: <20231208103940.153734-1-beanhuo@iokpp.de>
 <20231208103940.153734-3-beanhuo@iokpp.de>
 <20231208145021.GC15552@thinkpad>
 <89c02f8b999a90329f2125380ad2d984767d25ae.camel@iokpp.de>
 <20231208170609.GD15552@thinkpad>
 <20231208173118.GE15552@thinkpad>
 <31f011c3d25bf63ed2b8a17ecf89f5bf70d8548c.camel@iokpp.de>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31f011c3d25bf63ed2b8a17ecf89f5bf70d8548c.camel@iokpp.de>

On Sun, Dec 10, 2023 at 08:15:15PM +0100, Bean Huo wrote:
> On Fri, 2023-12-08 at 23:01 +0530, Manivannan Sadhasivam wrote:
> > > > 
> > > > Thank you for your reviews. I will incorporate the suggested
> > > > changes
> > > > into the patch, addressing all comments except for the RTC mode
> > > > switch.
> > > > The proposal is to perform the RTC mode switch during UFS
> > > > provisioning,
> > > > not at runtime in the UFS online phase. This approach ensures
> > > > that the
> > > > UFS configuration is populated based on the RTC configuration
> > > > established during provisioning. It is advisable not to change
> > > > the RTC
> > > > mode after provisioning is complete. Additionally, the usage of
> > > > tv_sec,
> > > > which returns time elapsed since boot, suggests that there is no
> > > > issue
> > > > with utilizing the RTC in this context.
> > > 
> > > Except that the warning will be issued to users after each 10s for
> > > 40 years.
> > > Atleast get rid of that.
> > > 
> > 
> > I tried this series on Qcom RB5 board and found the issue due to the
> > usage of
> > UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH flag. When this flag is
> > set,
> > ufshcd_device_init() will be called twice due to reinit of the
> > controller and
> > PHY.
> > 
> > Since RTC work is initialized and scheduled from
> > ufshcd_device_init(), panic
> > happens during second time. Is it possible to move RTC init outside
> > of
> > ufshcd_device_init(). Maybe you can parse RTC params in
> > ufshcd_device_init()
> > and initialize the work elsewhere. Or you can cancel the work before
> > calling
> > ufshcd_device_init() second time.
> > 
> > - Mani
> 
> 
> Thank you for your review. I have moved the INIT_DELAYED_WORK(&hba-
> >ufs_rtc_update_work, ufshcd_rtc_work) to ufshcd_init() from
> ufs_init_rtc(). This modification has been tested on the Qcom platform.

This works, thanks!

- Mani

> Regarding the warning, instead of removing it entirely, I have switched
> it to dev_dbg. This adjustment is made with the consideration that some
> form of customer notification is still necessary.
> 
> changes as below:
> 
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 953d50cc4256..cb6b0c286367 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8205,7 +8205,7 @@ static void ufshcd_update_rtc(struct ufs_hba
> *hba)
>         ktime_get_real_ts64(&ts64);
>  
>         if  (ts64.tv_sec < hba->dev_info.rtc_time_baseline) {
> -               dev_warn(hba->dev, "%s: Current time precedes previous
> setting!\n", __func__);
> +               dev_dbg(hba->dev, "%s: Current time precedes previous
> setting!\n", __func__);
>                 return;
>         }
>         /*
> @@ -8270,8 +8270,6 @@ static void  ufs_init_rtc(struct ufs_hba *hba, u8
> *desc_buf)
>          * update work, and let user configure by sysfs node according
> to specific circumstance.
>          */
>         hba->dev_info.rtc_update_period = 0;
> -
> -       INIT_DELAYED_WORK(&hba->ufs_rtc_update_work, ufshcd_rtc_work);
>  }
>  
>  static int ufs_get_device_desc(struct ufs_hba *hba)
> @@ -10634,8 +10632,8 @@ int ufshcd_init(struct ufs_hba *hba, void
> __iomem *mmio_base, unsigned int irq)
>                                                 UFS_SLEEP_PWR_MODE,
>                                                
> UIC_LINK_HIBERN8_STATE);
>  
> -       INIT_DELAYED_WORK(&hba->rpm_dev_flush_recheck_work,
> -                         ufshcd_rpm_dev_flush_recheck_work);
> +       INIT_DELAYED_WORK(&hba->rpm_dev_flush_recheck_work,
> ufshcd_rpm_dev_flush_recheck_work);
> +       INIT_DELAYED_WORK(&hba->ufs_rtc_update_work, ufshcd_rtc_work);
>  
>         /* Set the default auto-hiberate idle timer value to 150 ms */
>         if (ufshcd_is_auto_hibern8_supported(hba) && !hba->ahit) {
> 
> Kind regards,
> Bean

-- 
மணிவண்ணன் சதாசிவம்

