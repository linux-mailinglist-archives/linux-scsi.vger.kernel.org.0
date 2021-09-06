Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CFC40206B
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Sep 2021 21:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbhIFTfv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 6 Sep 2021 15:35:51 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:41958 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231854AbhIFTfu (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 6 Sep 2021 15:35:50 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id D8A354CE08;
        Mon,  6 Sep 2021 19:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1630956883; x=
        1632771284; bh=QSA24g5B4PSm4NySDH8UHeyeCilB1fidf8fXx60AV9U=; b=k
        R3JLZ6vo8tlVnVjbtBMd1VzNasOQeFklNURz87eKx2k/bqVXptX2T7Jbx/5Yc9K6
        cEBM1rTVzj7u5VhvVj2SXy43xY35kH36OMMDiZ/Ju7VS/8nyY6gTBKCiFEqsDqKf
        mGEv/rgd6kUwiXxg/sTBEIM/2XS7zu7F0r3i7k1Yiw=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VkEADWW7H_67; Mon,  6 Sep 2021 22:34:43 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id AA4EF4CC48;
        Mon,  6 Sep 2021 22:34:42 +0300 (MSK)
Received: from yadro.com (10.199.0.58) by T-EXCH-04.corp.yadro.com
 (172.17.100.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 6 Sep
 2021 22:34:41 +0300
From:   Sergey Samoylenko <s.samoylenko@yadro.com>
To:     <martin.petersen@oracle.com>, <michael.christie@oracle.com>,
        <ddiss@suse.de>, <bvanassche@acm.org>,
        <target-devel@vger.kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Sergey Samoylenko <s.samoylenko@yadro.com>
Subject: [v2 0/1] scsi: target: Add 8Fh VPD page
Date:   Mon, 6 Sep 2021 22:34:03 +0300
Message-ID: <20210906193404.115711-1-s.samoylenko@yadro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.58]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-04.corp.yadro.com (172.17.100.104)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Patch adds Third-party Copy VPD in TCM.

Changes since v1:
- add buffer overflow detect for spc_evpd_8f_encode_HELPER functions

Sergey Samoylenko (1):
  scsi: target: Add 8Fh VPD page

 drivers/target/target_core_spc.c | 264 ++++++++++++++++++++++++++++++-
 1 file changed, 260 insertions(+), 4 deletions(-)

-- 
2.25.1

