Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 310D5109241
	for <lists+linux-scsi@lfdr.de>; Mon, 25 Nov 2019 17:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfKYQ5Q (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 25 Nov 2019 11:57:16 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:39572 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728683AbfKYQ5Q (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 25 Nov 2019 11:57:16 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id DDF6B43E0C;
        Mon, 25 Nov 2019 16:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1574701032; x=
        1576515433; bh=sU1BIF8Rmzky8FbGgMdJUBF7uj6s8srs/AhB8fwRX0k=; b=Z
        NR90IkHIL46hIZKZQAdK3pwIlQLlMr37Y7ghkfz6qD23hLC+3qWg2PwuVG+hp0SE
        ss31Robrllka+5rWEzHSvPekZGmGinkqjlB8tugnNqHjrXcccWj0DBsZTZD5fgh0
        myu+ilk0gRHaXDHzEDSm0YbbcGGStn6u6VJepD3WVI=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ndmo99cr8nuB; Mon, 25 Nov 2019 19:57:12 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 6C39A411FF;
        Mon, 25 Nov 2019 19:57:12 +0300 (MSK)
Received: from localhost (172.17.128.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 25
 Nov 2019 19:57:11 +0300
From:   Roman Bolshakov <r.bolshakov@yadro.com>
To:     <linux-scsi@vger.kernel.org>, <target-devel@vger.kernel.org>
CC:     <linux@yadro.com>, Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v3 00/13] scsi: qla2xxx: Bug fixes
Date:   Mon, 25 Nov 2019 19:56:49 +0300
Message-ID: <20191125165702.1013-1-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.128.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

The patch series contains fixes for qla2xxx and solves two visible
issues:
  - Target port in N2N topology doesn't perform login if it has higher
    WWPN than initiator
  - ABORT TASK TMF leads to crash if it's received shortly after ACL of
    an initiator is deleted and there's active I/O from the initiator

It also contains reliability improvements and cleanups.

Changes since v2 (https://patchwork.kernel.org/cover/11254937/):
- Target is allowed to perform PLOGI only if it detects N2N mode;
- Dropped patches to improve ABTS handling for ports that are not
  currently logged in. They will go into a separate patch series.
Changes since v1 (https://patchwork.kernel.org/cover/11141979/):
- Fixes target port in N2N mode were added (patches 5-11);
- Target port makes explicit LOGO on session teardown in the patch made
  by Quinn. Together with patch 1, it helps to immediately turn
  fc_remote_port to the Blocked stated on client side and avoids visibly
  stuck session;
- The last three patches address violation of FCP specification with
  regards to handling of ABTS-LS from ports that are not currently
  logged in.

Thank you,
Roman

Quinn Tran (1):
  scsi: qla2xxx: Use explicit LOGO in target mode

Roman Bolshakov (12):
  scsi: qla2xxx: Ignore NULL pointer in tcm_qla2xxx_free_mcmd
  scsi: qla2xxx: Initialize free_work before flushing it
  scsi: qla2xxx: Drop superfluous INIT_WORK of del_work
  scsi: qla2xxx: Change discovery state before PLOGI
  scsi: qla2xxx: Allow PLOGI in target mode
  scsi: qla2xxx: Don't call qlt_async_event twice
  scsi: qla2xxx: Fix PLOGI payload and ELS IOCB dump length
  scsi: qla2xxx: Configure local loop for N2N target
  scsi: qla2xxx: Send Notify ACK after N2N PLOGI
  scsi: qla2xxx: Don't defer relogin unconditonally
  scsi: qla2xxx: Ignore PORT UPDATE after N2N PLOGI
  scsi: qla2xxx: Add debug dump of LOGO payload and ELS IOCB

 drivers/scsi/qla2xxx/qla_def.h     |  1 +
 drivers/scsi/qla2xxx/qla_init.c    | 21 ++++++++++----------
 drivers/scsi/qla2xxx/qla_iocb.c    | 31 ++++++++++++++++++++++++------
 drivers/scsi/qla2xxx/qla_isr.c     |  4 ----
 drivers/scsi/qla2xxx/qla_mbx.c     |  3 ++-
 drivers/scsi/qla2xxx/qla_target.c  |  4 ++--
 drivers/scsi/qla2xxx/tcm_qla2xxx.c |  3 +++
 7 files changed, 43 insertions(+), 24 deletions(-)

-- 
2.24.0

