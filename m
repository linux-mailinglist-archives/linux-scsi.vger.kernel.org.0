Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2BD40AC13
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Sep 2021 12:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhINK5K (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Sep 2021 06:57:10 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:42330 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231667AbhINK5G (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 14 Sep 2021 06:57:06 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id B725B41EC6;
        Tue, 14 Sep 2021 10:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1631616947; x=
        1633431348; bh=dzF86nFJKr+WsWfK/sjWMAEgztPwEFGz6YY3um8OFYg=; b=A
        VU+lDXMSdOCTxSlVMLqfi02Xt/WBenpw4bXso4y5nIl+VmutC8poX5TYRO/gNw15
        JlU1rsONOPD9ehd6R8CTxp4qYgdnkLrOiUCeZucX92Wn6bcAd+TukaaZsHcMneTe
        hPe+7OkRiF0qAM01BG1CDNT1N0N24hhZH3FudPO5FI=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id i_MqmQepmaCx; Tue, 14 Sep 2021 13:55:47 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id A06FE41E83;
        Tue, 14 Sep 2021 13:55:47 +0300 (MSK)
Received: from NB-591.corp.yadro.com (10.199.0.9) by T-EXCH-04.corp.yadro.com
 (172.17.100.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 14
 Sep 2021 13:55:46 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        James Smart <james.smart@broadcom.com>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Subject: [PATCH 0/3] efct fixes & improvements
Date:   Tue, 14 Sep 2021 13:55:36 +0300
Message-ID: <20210914105539.6942-1-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.9]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-04.corp.yadro.com (172.17.100.104)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patchset contains fixes of some isues that were found during
evaluation of Emulex HBA as a target.

This patchset is intended for scsi-queue.

Dmitry Bogdanov (3):
  scsi: efct: add state in nport sm trace printout
  scsi: efct: fix nport free
  scsi: efct: decrease area under spinlock

 drivers/scsi/elx/efct/efct_scsi.c  | 3 +--
 drivers/scsi/elx/libefc/efc.h      | 2 +-
 drivers/scsi/elx/libefc/efc_cmds.c | 7 ++++++-
 drivers/scsi/elx/libefc/efclib.h   | 1 +
 4 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.25.1

