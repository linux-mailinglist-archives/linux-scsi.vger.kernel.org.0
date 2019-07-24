Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCF657272A
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Jul 2019 07:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfGXFIu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 24 Jul 2019 01:08:50 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46305 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725894AbfGXFIt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 24 Jul 2019 01:08:49 -0400
X-UUID: 4a06b605661c4987865286829ec6b91f-20190724
X-UUID: 4a06b605661c4987865286829ec6b91f-20190724
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 647929779; Wed, 24 Jul 2019 13:08:26 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 24 Jul 2019 13:08:24 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 24 Jul 2019 13:08:25 +0800
Message-ID: <1563944904.7235.8.camel@mtkswgap22>
Subject: RE: [PATCH v1 0/2] scsi: ufs: Fix broken hba->outstanding_tasks
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
Date:   Wed, 24 Jul 2019 13:08:24 +0800
In-Reply-To: <SN6PR04MB49256F66F259185F3876CCABFCC40@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1562906656-27154-1-git-send-email-stanley.chu@mediatek.com>
         <SN6PR04MB4925208835D4760249E82DB7FCC50@SN6PR04MB4925.namprd04.prod.outlook.com>
         <SN6PR04MB49256F66F259185F3876CCABFCC40@SN6PR04MB4925.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Avri,

On Mon, 2019-07-22 at 06:10 +0000, Avri Altman wrote:
> > 
> > >
> > > Hi,
> > >
> > > >
> > > > Currently bits in hba->outstanding_tasks are cleared only after their
> > > > corresponding task management commands are successfully done by
> > > > __ufshcd_issue_tm_cmd().
> > > >
> > > > If timeout happens in a task management command, its corresponding
> > > > bit in hba->outstanding_tasks will not be cleared until next task
> > > > management command with the same tag used successfully finishes.‧
> > > ufshcd_clear_tm_cmd is also called as part of ufshcd_err_handler.
> > > Does this change something in your assumptions?
> > And BTW there is a specific __clear_bit in __ufshcd_issue_tm_cmd() in case
> > of a TO.
> 
> Gave it another look - 
> If indeed this bit isn't cleared as part of the error flow that the timeout triggers,
> I think you should relate to ufshcd_clear_tm_cmd specifically in your commit log - 
> Because this is the obvious place where the bit cleanup should take place.
> 
> Also the fix should be much more intuitive IMO - 
> Today we do __clear_bit() on success, ufshcd_clear_tm_cmd() on error,
> And also ufshcd_put_tm_slot() either way?
> 
> Maybe you can choose a single place to clear it, without any additional code?

ufshcd_clear_tm_cmd() is similar to ufshcd_clear_cmd() which tries to
write timed-out bit in "clear register". They do not clean bits in both
outstanding masks.

Another reason to not to do outstanding bits cleanup in
ufshcd_clear_tm_cmd() is: if host is unable to clear TM command by
setting "clear register", the TM command may be still "outstanding" in
the device. In this case, it may be better to do cleanup after reset is
done. Cleanup includes bits in hba->outstanding_tasks and
hba->tm_slots_in_use which is possibly cleaned too early by
ufshcd_put_tm_slot() if command is timed-out now.

Referring to error handling flow of hba->outstanding_reqs, all timed-out
bits will be cleaned by ufshcd_reset_and_restore() =>
ufshcd_transfer_req_compl() after reset is done. Similar handling for
hba->outstanding_tasks could be applied, i.e., do cleanup by
ufshcd_reset_and_restore() => ufshcd_tmc_handler().

The next thing is what you suggested: How to make the fix more
intuitive. Patchset v2 will be uploaded for review: It tries to
"re-factor" cleanup jobs first, and then add fixed flow to make the
whole patch more readable.

One more thing, above description and flow is done through UFSHCD SCSI
error handling routines registered with SCSI Midlayer. For TM command
timeout happening in bsg path without error handling triggered by SCSI
layer, we may need to consider to handle those tasks in future patches.

> 
> Thanks,
> Avri

Thanks,
Stanley

> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


