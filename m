Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1B12395C
	for <lists+linux-scsi@lfdr.de>; Mon, 20 May 2019 16:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbfETOFm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 May 2019 10:05:42 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:23132 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730669AbfETOFm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 May 2019 10:05:42 -0400
X-UUID: 8af66a61be8e4e64acf2807f9c7fe1a0-20190520
X-UUID: 8af66a61be8e4e64acf2807f9c7fe1a0-20190520
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1397006878; Mon, 20 May 2019 22:05:36 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 20 May 2019 22:05:29 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 20 May 2019 22:05:29 +0800
Message-ID: <1558361129.660.8.camel@mtkswgap22>
Subject: RE: [PATCH v3 2/3] scsi: ufs: Add error-handling of Auto-Hibernate
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Avri Altman <Avri.Altman@wdc.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "pedrom.sousa@synopsys.com" <pedrom.sousa@synopsys.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "andy.teng@mediatek.com" <andy.teng@mediatek.com>,
        "chun-hung.wu@mediatek.com" <chun-hung.wu@mediatek.com>,
        "kuohong.wang@mediatek.com" <kuohong.wang@mediatek.com>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>
Date:   Mon, 20 May 2019 22:05:29 +0800
In-Reply-To: <SN6PR04MB4925DE7B66A63ED81EDD9444FC060@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1558341138-18043-1-git-send-email-stanley.chu@mediatek.com>
         <1558341138-18043-3-git-send-email-stanley.chu@mediatek.com>
         <SN6PR04MB4925DE7B66A63ED81EDD9444FC060@SN6PR04MB4925.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Avri,

On Mon, 2019-05-20 at 09:51 +0000, Avri Altman wrote:
> Aside from some nits - see below, looks fine.
> 
> Thanks,
> Avri
> 
> > diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> > index ecfa898b9ccc..994d73d03207 100644
> > --- a/drivers/scsi/ufs/ufshcd.h
> > +++ b/drivers/scsi/ufs/ufshcd.h
> > @@ -740,6 +740,11 @@ return true;
> >  #endif
> >  }
> > 
> > +static inline bool ufshcd_is_auto_hibern8_supported(struct ufs_hba *hba)
> > +{
> > +	return (hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT);
> > +}
> Maybe use it elsewhere in the driver, preferable in a preparatory patch,
> Instead of patch #3.
> 

OK. I will modify original patch #3 to a preparation patch which just
re-factors ufshcd_is_auto_hibern8_supported(), and change its order to
#2.
> 
> 
> > diff --git a/drivers/scsi/ufs/ufshci.h b/drivers/scsi/ufs/ufshci.h
> > index 6fa889de5ee5..4bcb205f2077 100644
> > --- a/drivers/scsi/ufs/ufshci.h
> > +++ b/drivers/scsi/ufs/ufshci.h
> > @@ -148,6 +148,9 @@ enum {
> >  				UIC_HIBERNATE_EXIT |\
> >  				UIC_POWER_MODE)
> > 
> > +#define UFSHCD_UIC_AH8_ERROR_MASK	(UIC_HIBERNATE_ENTER |\
> > +					UIC_HIBERNATE_EXIT)
> So maybe update UFSHCD_UIC_PWR_MASK above

OK.
WIll make these definitions more elegant.

> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

Thanks,
Stanley


