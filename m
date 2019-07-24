Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7B7C7278C
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Jul 2019 07:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfGXFu1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 24 Jul 2019 01:50:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:63363 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725870AbfGXFu0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 24 Jul 2019 01:50:26 -0400
X-UUID: b8c38bb4e6904a04b24b198891de7917-20190724
X-UUID: b8c38bb4e6904a04b24b198891de7917-20190724
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 252950784; Wed, 24 Jul 2019 13:50:21 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 24 Jul 2019 13:50:20 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 24 Jul 2019 13:50:20 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <pedrom.sousa@synopsys.com>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <evgreen@chromium.org>, <beanhuo@micron.com>,
        <marc.w.gonzalez@free.fr>, <kuohong.wang@mediatek.com>,
        <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <andy.teng@mediatek.com>, Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v2 0/3] scsi: ufs: fix broken hba->outstanding_tasks
Date:   Wed, 24 Jul 2019 13:50:15 +0800
Message-ID: <1563947418-16394-1-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Currently bits in hba->outstanding_tasks are cleared only after their
corresponding task management commands are successfully done by
__ufshcd_issue_tm_cmd().

If timeout happens in a task management command, its corresponding
bit in hba->outstanding_tasks will not be cleared until next task
management command with the same tag used successfully finishes.

This is wrong and can lead to some issues, like power issue.
For example, ufshcd_release() and ufshcd_gate_work() will do nothing
if hba->outstanding_tasks is not zero even if both UFS host and devices
are actually idle.

Referring to error handling flow of hba->outstanding_reqs, all timed-out
bits will be cleared by
ufshcd_reset_and_restore() => ufshcd_transfer_req_compl()
after reset is done. Therefore similar handling for hba->outstanding_tasks
could be applied, for example, by
ufshcd_reset_and_restore() => ufshcd_tmc_handler().

This patch tries to "re-factor" cleanup jobs first, and then add fixed
flow to make the whole patch more readable.

Stanley Chu (3):
  scsi: ufs: clean-up task resource immediately only if task is
    responded
  scsi: ufs: introduce ufshcd_tm_cmd_compl() to refactor task cleanup
  scsi: ufs: fix broken hba->outstanding_tasks

 drivers/scsi/ufs/ufshcd.c | 41 ++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

-- 
2.18.0

