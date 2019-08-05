Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A683813D1
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Aug 2019 10:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfHEIBy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 5 Aug 2019 04:01:54 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41184 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEIBy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 5 Aug 2019 04:01:54 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7581as8080687;
        Mon, 5 Aug 2019 03:01:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564992096;
        bh=7sv9PjcFwV9v+UJTNk3jI9UE2QxN5A6jgKLgQowNCpA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SiF6CtKiRta8wjwuDh6WKaoLpEknj8qZReXU80pe5XITEbLAgQB1fZ5DI1OOqCb8h
         gQavyEiEzJ38lDba9+y0Q67tuDu0ZME1wMXXpCUzo3Dmq8VrcPhC+joI4mPtiNAjIO
         VJZ5w29F/ZYK13NaeL1JEE9uHWFUD+DcQ5BZjsbQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7581ZWM112160
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Aug 2019 03:01:36 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 5 Aug
 2019 03:01:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 5 Aug 2019 03:01:35 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7581VBW040191;
        Mon, 5 Aug 2019 03:01:31 -0500
Subject: Re: [PATCH v2] scsi: ufs: Configure clock in .hce_enable_notify() in
 Cadence UFS
To:     Anil Varughese <aniljoy@cadence.com>, <alim.akhtar@samsung.com>,
        <avri.altman@wdc.com>, <pedrom.sousa@synopsys.com>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hare@suse.de>,
        <rafalc@cadence.com>, <mparab@cadence.com>, <jank@cadence.com>,
        <pawell@cadence.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190802112112.18714-1-aniljoy@cadence.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <86985e8d-2aa8-5583-f899-925191f2041d@ti.com>
Date:   Mon, 5 Aug 2019 13:32:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802112112.18714-1-aniljoy@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

On 02/08/19 4:51 PM, Anil Varughese wrote:
> Configure CDNS_UFS_REG_HCLKDIV in .hce_enable_notify() instead of
> .setup_clock() because if UFSHCD resets the controller ip because
> of phy or device related errors then CDNS_UFS_REG_HCLKDIV is
> reset to default value and .setup_clock() is not called later
> in the sequence whereas .hce_enable_notify will be called everytime
> controller is reenabled.
> 
> Signed-off-by: Anil Varughese <aniljoy@cadence.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

>  drivers/scsi/ufs/cdns-pltfrm.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/cdns-pltfrm.c b/drivers/scsi/ufs/cdns-pltfrm.c
> index 86dbb723f..993519080 100644
> --- a/drivers/scsi/ufs/cdns-pltfrm.c
> +++ b/drivers/scsi/ufs/cdns-pltfrm.c
> @@ -62,17 +62,16 @@ static int cdns_ufs_set_hclkdiv(struct ufs_hba *hba)
>  }
>  
>  /**
> - * Sets clocks used by the controller
> + * Called before and after HCE enable bit is set.
>   * @hba: host controller instance
> - * @on: if true, enable clocks, otherwise disable
>   * @status: notify stage (pre, post change)
>   *
>   * Return zero for success and non-zero for failure
>   */
> -static int cdns_ufs_setup_clocks(struct ufs_hba *hba, bool on,
> -				 enum ufs_notify_change_status status)
> +static int cdns_ufs_hce_enable_notify(struct ufs_hba *hba,
> +				      enum ufs_notify_change_status status)
>  {
> -	if ((!on) || (status == PRE_CHANGE))
> +	if (status != PRE_CHANGE)
>  		return 0;
>  
>  	return cdns_ufs_set_hclkdiv(hba);
> @@ -114,13 +113,13 @@ static int cdns_ufs_m31_16nm_phy_initialization(struct ufs_hba *hba)
>  
>  static const struct ufs_hba_variant_ops cdns_ufs_pltfm_hba_vops = {
>  	.name = "cdns-ufs-pltfm",
> -	.setup_clocks = cdns_ufs_setup_clocks,
> +	.hce_enable_notify = cdns_ufs_hce_enable_notify,
>  };
>  
>  static const struct ufs_hba_variant_ops cdns_ufs_m31_16nm_pltfm_hba_vops = {
>  	.name = "cdns-ufs-pltfm",
>  	.init = cdns_ufs_init,
> -	.setup_clocks = cdns_ufs_setup_clocks,
> +	.hce_enable_notify = cdns_ufs_hce_enable_notify,
>  	.phy_initialization = cdns_ufs_m31_16nm_phy_initialization,
>  };
>  
> 

-- 
Regards
Vignesh
