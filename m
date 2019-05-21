Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7101524812
	for <lists+linux-scsi@lfdr.de>; Tue, 21 May 2019 08:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfEUG3y (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 02:29:54 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:43547 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725924AbfEUG3x (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 02:29:53 -0400
X-UUID: 043ac684d4704eb9970175fb674b8ef0-20190521
X-UUID: 043ac684d4704eb9970175fb674b8ef0-20190521
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 735693814; Tue, 21 May 2019 14:29:47 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 21 May 2019 14:29:45 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 21 May 2019 14:29:45 +0800
Message-ID: <1558420185.660.9.camel@mtkswgap22>
Subject: RE: [PATCH v4 2/3] scsi: ufs: Introduce
 ufshcd_is_auto_hibern8_supported()
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Avri Altman <Avri.Altman@wdc.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
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
Date:   Tue, 21 May 2019 14:29:45 +0800
In-Reply-To: <SN6PR04MB4925EAB455D857AEB055258FFC070@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1558361445-30994-1-git-send-email-stanley.chu@mediatek.com>
         <1558361445-30994-3-git-send-email-stanley.chu@mediatek.com>
         <SN6PR04MB4925EAB455D857AEB055258FFC070@SN6PR04MB4925.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 654E7C1331B3670E11854CE7A262AB6C908DCE4D8CDB3BB365F47B68D9F001742000:8
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Avri,

On Tue, 2019-05-21 at 06:18 +0000, Avri Altman wrote:
> > 
> > ufshcd_is_auto_hibern8_supported() will be used elsewhere
> > in the driver, thus refactor it for preparation.
> You missed a couple of spots, e.g. in ufshcd_auto_hibern8_enable and in ufs-sysfs.

Yes...
Will re-factor them as well in next version.

> 
> Thanks,
> Avri

Thanks,
Stanley


