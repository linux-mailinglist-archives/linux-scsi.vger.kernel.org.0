Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E053A22B6C
	for <lists+linux-scsi@lfdr.de>; Mon, 20 May 2019 07:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbfETFuw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 May 2019 01:50:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:4367 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725829AbfETFuv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 May 2019 01:50:51 -0400
X-UUID: 4f3035774b5e4bd393fdfafdb2981709-20190520
X-UUID: 4f3035774b5e4bd393fdfafdb2981709-20190520
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 691229632; Mon, 20 May 2019 13:50:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 20 May 2019 13:50:44 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 20 May 2019 13:50:44 +0800
Message-ID: <1558331444.660.3.camel@mtkswgap22>
Subject: RE: [PATCH v2 1/3] scsi: ufs: Do not overwrite Auto-Hibernate timer
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Avri Altman <Avri.Altman@wdc.com>
CC:     Alim Akhtar <alim.akhtar@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "pedrom.sousa@synopsys.com" <pedrom.sousa@synopsys.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "kuohong.wang@mediatek.com" <kuohong.wang@mediatek.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "chun-hung.wu@mediatek.com" <chun-hung.wu@mediatek.com>,
        "andy.teng@mediatek.com" <andy.teng@mediatek.com>
Date:   Mon, 20 May 2019 13:50:44 +0800
In-Reply-To: <SN6PR04MB4925D68D8D8EF2E16FD6525AFC060@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1557912988-26758-1-git-send-email-stanley.chu@mediatek.com>
         <CGME20190515093640epcas2p17e4c3e4545ce5e4e4b59ed7b9a954741@epcas2p1.samsung.com>
         <1557912988-26758-2-git-send-email-stanley.chu@mediatek.com>
         <15a271c6-88c8-b9d5-68a8-dc142afdf224@samsung.com>
         <SN6PR04MB4925D68D8D8EF2E16FD6525AFC060@SN6PR04MB4925.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: C35318FB76C1B6118FB9D57F33EED020122AB4D17243F9CEC9A0A82013BC28C42000:8
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Avri,

On Mon, 2019-05-20 at 05:47 +0000, Avri Altman wrote:
> > 
> > Hello Stanley,
> > 
> > On 5/15/19 3:06 PM, Stanley Chu wrote:
> > > Some vendor-specific initialization flow may set its own
> > > auto-hibernate timer. In this case, do not overwrite timer value
> > > as "default value" in ufshcd_init().
> > >
> > > Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> > > ---
> > >   drivers/scsi/ufs/ufshcd.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> > > index e040f9dd9ff3..1665820c22fd 100644
> > > --- a/drivers/scsi/ufs/ufshcd.c
> > > +++ b/drivers/scsi/ufs/ufshcd.c
> > > @@ -8309,7 +8309,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem
> > *mmio_base, unsigned int irq)
> > >   						UIC_LINK_HIBERN8_STATE);
> > >
> > >   	/* Set the default auto-hiberate idle timer value to 150 ms */
> > > -	if (hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT) {
> > > +	if (hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT & !hba->ahit) {
> A typo?

Yes! Thanks for remind this.
Will fix it in next version.

> 
> 
> > >   		hba->ahit = FIELD_PREP(UFSHCI_AHIBERN8_TIMER_MASK,
> > 150) |
> > >   			    FIELD_PREP(UFSHCI_AHIBERN8_SCALE_MASK, 3);
> > >   	}
> > >
> > Looks good to me,
> > Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

Thanks.
Stanley

