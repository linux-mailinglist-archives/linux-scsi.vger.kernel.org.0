Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCA8074961
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jul 2019 10:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389863AbfGYIw1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 25 Jul 2019 04:52:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45174 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388546AbfGYIw0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 25 Jul 2019 04:52:26 -0400
X-UUID: 7e8b144a836249988593ea0d9a01323b-20190725
X-UUID: 7e8b144a836249988593ea0d9a01323b-20190725
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1623952815; Thu, 25 Jul 2019 16:52:18 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 25 Jul 2019 16:52:17 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 25 Jul 2019 16:52:17 +0800
Message-ID: <1564044737.7235.9.camel@mtkswgap22>
Subject: RE: [PATCH v2 0/3] scsi: ufs: fix broken hba->outstanding_tasks
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
Date:   Thu, 25 Jul 2019 16:52:17 +0800
In-Reply-To: <MN2PR04MB69914824302B84E144137869FCC10@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <1563947418-16394-1-git-send-email-stanley.chu@mediatek.com>
         <MN2PR04MB69914824302B84E144137869FCC10@MN2PR04MB6991.namprd04.prod.outlook.com>
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

On Thu, 2019-07-25 at 07:54 +0000, Avri Altman wrote:
> Stanly,
> 
> > 
> > Currently bits in hba->outstanding_tasks are cleared only after their
> > corresponding task management commands are successfully done by
> > __ufshcd_issue_tm_cmd().
> > 
> > If timeout happens in a task management command, its corresponding
> > bit in hba->outstanding_tasks will not be cleared until next task
> > management command with the same tag used successfully finishes.
> I'm sorry - I still don't understand why you just can't release the tag either way,
> Just like we do in device management queries tags,
> Instead of adding all this unnecessary code.
> 
> I will not object to your series -
> just step down and let other people review you patches.


Sorry to not describe the failed scenario clearly.

Simpliy focus on outstanding bits cleanup in failed (timeout) case:
- For device command, if timeout happens, its tag can be cleared in
ufshcd_wait_for_dev_cmd() which specifically uses
ufshcd_outstanding_req_clear() to clear failed bit in outstanding_reqs
mask.
- For task management command, if timeout happens, current driver will
not clear failed bit in outstanding_tasks mask:
	- __ufshcd_issue_tm_cmd() will not clear it,
	- ufshcd_tmc_handler() will not clear it either during reset flow.

> Thanks,
> Avri

Thanks,
Stanley

> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


