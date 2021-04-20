Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32828365FE5
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Apr 2021 20:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhDTTA2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 20 Apr 2021 15:00:28 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:52954 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233541AbhDTTA1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 20 Apr 2021 15:00:27 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 7CD0841399;
        Tue, 20 Apr 2021 18:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1618945193; x=
        1620759594; bh=mBFonvNyfhwXdP0YxwKa9464TvbOOHPM9Cs3w/vkPaU=; b=Q
        8h7vS+zKHh6pxxoHnzKdGkd30KrWEQSbGCqbpBcqT7VJ+8zK7f83aAJMH/A/n3XL
        340FV7Yow/YjBFGEfQimki5dzkxvXREFpj8gOgDZQrU3CvfiQ63625EY7X4vELTr
        M8PkZ132jLrS/QK9uBMDbFI/d9OFLDpKVJWuuuVte4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gZIlNBgBdjlF; Tue, 20 Apr 2021 21:59:53 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 816BE41318;
        Tue, 20 Apr 2021 21:59:53 +0300 (MSK)
Received: from yadro.com (10.199.0.227) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 20
 Apr 2021 21:59:53 +0300
From:   Sergey Samoylenko <s.samoylenko@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     David Disseldorp <ddiss@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux@yadro.com>, Sergey Samoylenko <s.samoylenko@yadro.com>
Subject: [PATCH RESEND 0/2] scsi: target: user configurable IEEE Company ID
Date:   Tue, 20 Apr 2021 21:59:18 +0300
Message-ID: <20210420185920.42431-1-s.samoylenko@yadro.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.227]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The series allows to change IEEE Company ID component
of NAA LUN identifier returned on the SCSI INQUIRY VPD
page (aka WWID). Company ID can be changed via the
target/core/$backstore/$name/wwn/company_id ConfigFS path.

Sergey Samoylenko (2):
  scsi: target: core: Unify NAA identifer generation
  scsi: target: core: Add IEEE Company ID attribute

 drivers/target/target_core_configfs.c | 50 +++++++++++++++++++++++++++
 drivers/target/target_core_device.c   |  5 +++
 drivers/target/target_core_pr.h       |  2 +-
 drivers/target/target_core_spc.c      | 47 ++++++++++++-------------
 drivers/target/target_core_xcopy.c    | 17 ++-------
 include/target/target_core_base.h     |  1 +
 6 files changed, 82 insertions(+), 40 deletions(-)

-- 
2.27.0

