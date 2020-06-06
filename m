Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEEE1F090C
	for <lists+linux-scsi@lfdr.de>; Sun,  7 Jun 2020 01:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgFFX2b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Sat, 6 Jun 2020 19:28:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:54184 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728631AbgFFX2a (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 6 Jun 2020 19:28:30 -0400
IronPort-SDR: ByHdZ0rLPU1KpECvvrDx2603g9CcuIJjl9MK//h7o+uYhdLVvKGU9ms6nSM/uvyDD1AZyn90zu
 3EbliYWEQBlg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2020 16:28:29 -0700
IronPort-SDR: 3g2TkjMhcgIIZypQZ8+xavgUSkzRtojFWzrnvIM8kpb/KrItSzmLgGhE3hKi0dMifsT9IdN5GL
 Egf2q875184w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,482,1583222400"; 
   d="scan'208";a="270136311"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga003.jf.intel.com with ESMTP; 06 Jun 2020 16:28:28 -0700
Received: from lcsmsx601.ger.corp.intel.com (10.109.210.10) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 6 Jun 2020 16:28:28 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX601.ger.corp.intel.com (10.109.210.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 7 Jun 2020 02:28:25 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Sun, 7 Jun 2020 02:28:25 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Bean Huo <huobean@gmail.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] scsi: ufs: remove wrapper function
 ufshcd_setup_clocks()
Thread-Topic: [PATCH v3 2/2] scsi: ufs: remove wrapper function
 ufshcd_setup_clocks()
Thread-Index: AQHWO3S7gFtcaJKwGkOhBlXWlS1UyqjMPK7g
Date:   Sat, 6 Jun 2020 23:28:25 +0000
Message-ID: <bd961d352864412381ca551512ea759e@intel.com>
References: <20200605200520.20831-1-huobean@gmail.com>
 <20200605200520.20831-3-huobean@gmail.com>
In-Reply-To: <20200605200520.20831-3-huobean@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
x-originating-ip: [10.184.70.1]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


> 
> From: Bean Huo <beanhuo@micron.com>
> 
> The static function ufshcd_setup_clocks() is just a wrapper around
> __ufshcd_setup_clocks(), remove it. Rename original function wrapped
> __ufshcd_setup_clocks() to new ufshcd_setup_clocks().

Not sure about this change, we have only one call with skip_ref_clock set to true, the original code actually make sense from readability stand point. 

> 
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>  drivers/scsi/ufs/ufshcd.c | 32 ++++++++++++--------------------
>  1 file changed, 12 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c index
> ec4f55211648..531d0b7878db 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -215,9 +215,7 @@ static int ufshcd_eh_host_reset_handler(struct
> scsi_cmnd *cmd);  static int ufshcd_clear_tm_cmd(struct ufs_hba *hba, int
> tag);  static void ufshcd_hba_exit(struct ufs_hba *hba);  static int
> ufshcd_probe_hba(struct ufs_hba *hba, bool async); -static int
> __ufshcd_setup_clocks(struct ufs_hba *hba, bool on,
> -				 bool skip_ref_clk);
> -static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on);
> +static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on, bool
> +skip_ref_clk);
>  static int ufshcd_uic_hibern8_enter(struct ufs_hba *hba);  static inline void
> ufshcd_add_delay_before_dme_cmd(struct ufs_hba *hba);  static int
> ufshcd_host_reset_and_restore(struct ufs_hba *hba); @@ -1497,7 +1495,7
> @@ static void ufshcd_ungate_work(struct work_struct *work)
>  	}
> 
>  	spin_unlock_irqrestore(hba->host->host_lock, flags);
> -	ufshcd_setup_clocks(hba, true);
> +	ufshcd_setup_clocks(hba, true, false);
> 
>  	ufshcd_enable_irq(hba);
> 
> @@ -1655,10 +1653,10 @@ static void ufshcd_gate_work(struct work_struct
> *work)
>  	ufshcd_disable_irq(hba);
> 
>  	if (!ufshcd_is_link_active(hba))
> -		ufshcd_setup_clocks(hba, false);
> +		ufshcd_setup_clocks(hba, false, false);
>  	else
>  		/* If link is active, device ref_clk can't be switched off */
> -		__ufshcd_setup_clocks(hba, false, true);
> +		ufshcd_setup_clocks(hba, false, true);
> 
>  	/*
>  	 * In case you are here to cancel this work the gating state @@ -
> 7683,8 +7681,7 @@ static int ufshcd_init_hba_vreg(struct ufs_hba *hba)
>  	return 0;
>  }
> 
> -static int __ufshcd_setup_clocks(struct ufs_hba *hba, bool on,
> -					bool skip_ref_clk)
> +static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on, bool
> +skip_ref_clk)
>  {
>  	int ret = 0;
>  	struct ufs_clk_info *clki;
> @@ -7747,11 +7744,6 @@ static int __ufshcd_setup_clocks(struct ufs_hba
> *hba, bool on,
>  	return ret;
>  }
> 
> -static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on) -{
> -	return  __ufshcd_setup_clocks(hba, on, false);
> -}
> -
>  static int ufshcd_init_clocks(struct ufs_hba *hba)  {
>  	int ret = 0;
> @@ -7858,7 +7850,7 @@ static int ufshcd_hba_init(struct ufs_hba *hba)
>  	if (err)
>  		goto out_disable_hba_vreg;
> 
> -	err = ufshcd_setup_clocks(hba, true);
> +	err = ufshcd_setup_clocks(hba, true, false);
>  	if (err)
>  		goto out_disable_hba_vreg;
> 
> @@ -7880,7 +7872,7 @@ static int ufshcd_hba_init(struct ufs_hba *hba)
>  out_disable_vreg:
>  	ufshcd_setup_vreg(hba, false);
>  out_disable_clks:
> -	ufshcd_setup_clocks(hba, false);
> +	ufshcd_setup_clocks(hba, false, false);
>  out_disable_hba_vreg:
>  	ufshcd_setup_hba_vreg(hba, false);
>  out:
> @@ -7896,7 +7888,7 @@ static void ufshcd_hba_exit(struct ufs_hba *hba)
>  		if (ufshcd_is_clkscaling_supported(hba))
>  			if (hba->devfreq)
>  				ufshcd_suspend_clkscaling(hba);
> -		ufshcd_setup_clocks(hba, false);
> +		ufshcd_setup_clocks(hba, false, false);
>  		ufshcd_setup_hba_vreg(hba, false);
>  		hba->is_powered = false;
>  		ufs_put_device_desc(hba);
> @@ -8259,10 +8251,10 @@ static int ufshcd_suspend(struct ufs_hba *hba,
> enum ufs_pm_op pm_op)
>  	ufshcd_disable_irq(hba);
> 
>  	if (!ufshcd_is_link_active(hba))
> -		ufshcd_setup_clocks(hba, false);
> +		ufshcd_setup_clocks(hba, false, false);
>  	else
>  		/* If link is active, device ref_clk can't be switched off */
> -		__ufshcd_setup_clocks(hba, false, true);
> +		ufshcd_setup_clocks(hba, false, true);
> 
>  	hba->clk_gating.state = CLKS_OFF;
>  	trace_ufshcd_clk_gating(dev_name(hba->dev), hba-
> >clk_gating.state); @@ -8321,7 +8313,7 @@ static int ufshcd_resume(struct
> ufs_hba *hba, enum ufs_pm_op pm_op)
> 
>  	ufshcd_hba_vreg_set_hpm(hba);
>  	/* Make sure clocks are enabled before accessing controller */
> -	ret = ufshcd_setup_clocks(hba, true);
> +	ret = ufshcd_setup_clocks(hba, true, false);
>  	if (ret)
>  		goto out;
> 
> @@ -8404,7 +8396,7 @@ static int ufshcd_resume(struct ufs_hba *hba,
> enum ufs_pm_op pm_op)
>  	ufshcd_disable_irq(hba);
>  	if (hba->clk_scaling.is_allowed)
>  		ufshcd_suspend_clkscaling(hba);
> -	ufshcd_setup_clocks(hba, false);
> +	ufshcd_setup_clocks(hba, false, false);
>  out:
>  	hba->pm_op_in_progress = 0;
>  	if (ret)
> --
> 2.17.1

