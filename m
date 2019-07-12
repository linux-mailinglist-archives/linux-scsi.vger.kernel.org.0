Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89C95665D9
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jul 2019 06:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbfGLEo3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 12 Jul 2019 00:44:29 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:13938 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729188AbfGLEo3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 12 Jul 2019 00:44:29 -0400
X-UUID: 4317ff5b31624b9c9681947c79ea7cd6-20190712
X-UUID: 4317ff5b31624b9c9681947c79ea7cd6-20190712
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1930554801; Fri, 12 Jul 2019 12:44:19 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 12 Jul 2019 12:44:17 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 12 Jul 2019 12:44:17 +0800
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
Subject: [PATCH v1 0/2] scsi: ufs: Fix broken hba->outstanding_tasks
Date:   Fri, 12 Jul 2019 12:44:14 +0800
Message-ID: <1562906656-27154-1-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-TM-SNTS-SMTP: 6CE500BED1A01CEE061009D235263B53C480307527484BCFEC3F55144357D55B2000:8
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
management command with the same tag used successfully finishes.‧

This is wrong and can lead to some issues, like power consumpton issue.
For example, ufshcd_release() and ufshcd_gate_work() will do nothing
if hba->outstanding_tasks is not zero even if both UFS host and devices
are actually idle.

Because error handling flow, i.e., ufshcd_reset_and_restore(), will be
triggered after any task management command times out, we fix this by
clearing corresponding hba->outstanding_tasks bits during this flow.
To achieve this, we need a mask to track timed-out commands and thus
error handling flow can clear their tags specifically.

Stanley Chu (2):
  scsi: ufs: Make new function for clearing outstanding task bits
  scsi: ufs: Fix broken hba->outstanding_tasks

 drivers/scsi/ufs/ufshcd.c | 49 +++++++++++++++++++++++++++++++++------
 drivers/scsi/ufs/ufshcd.h |  1 +
 2 files changed, 43 insertions(+), 7 deletions(-)

-- 
2.18.0

