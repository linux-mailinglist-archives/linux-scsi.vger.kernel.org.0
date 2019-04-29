Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3EAEA07
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Apr 2019 20:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfD2SWC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Apr 2019 14:22:02 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40135 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbfD2SWC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 29 Apr 2019 14:22:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so5459146plr.7
        for <linux-scsi@vger.kernel.org>; Mon, 29 Apr 2019 11:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gdxr67cGcWjm0r9fdtWRtUdHDiHf8cgaxy42FtsjKGM=;
        b=IF6ofVvKCvOaCR2g/hP/AZQPnCHm4TAyxXbi51xV7AxK2y0Kmrj9JkG+6ztUtSIJiL
         7H0z1558X5oRPAXQv4HdArSJNeyIBXbOSS0B0blVLlWw4dumrbqxEVhKyYtyVsM/LA5w
         2iBLTiv61vJn7jkxfCsFwTtuTe5ozBlJIcXPl4HJFl2+45uQqZ0WnSM2Y8Ir+B7ZeNwq
         Ib7OEPMgfKvfjT6BwRzqGR2TlaHkqIjDRdjT7e+yjUK3yZ6+Fo77Y2tZ8l/6kcfdultD
         M1po3K2Ibzq7GMIIdU/sCFTr4saHMf0mRlt9FngET3jEBuo8cvcF0Tu3KstJYWmms3Au
         wGHA==
X-Gm-Message-State: APjAAAXR1HNpn352J7PVRUm5D9I4PAIrI003PSpOBoV7jaZie00Y5Um2
        NDR5YN3S+ovm1X7vk+J35KE=
X-Google-Smtp-Source: APXvYqzmkDeeuyP82YzV9Nug9tIhfO6I/Q3Kqps9FM4EDy1OnPnuwYPtUR4QCwUfWNxVuacYpJEj8g==
X-Received: by 2002:a17:902:6842:: with SMTP id f2mr11035654pln.189.1556562122013;
        Mon, 29 Apr 2019 11:22:02 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id z22sm35657227pgv.23.2019.04.29.11.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 11:22:01 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Pavel Machek <pavel@ucw.cz>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/2] Revert the patches that rework sd probing
Date:   Mon, 29 Apr 2019 11:21:51 -0700
Message-Id: <20190429182153.206292-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

For a not yet fully root-caused reason patch "sd: Rely on the driver core
for asynchronous probing" causes trouble with suspend/resume. Since not
much time is left before the merge window opens, revert this patch and
also a patch that depends on it.

Thanks,

Bart.

Bart Van Assche (2):
  sd: Revert "Inline sd_probe_part2()"
  sd: Revert "Rely on the driver core for asynchronous probing"

 drivers/scsi/scsi.c      |  14 +++++
 drivers/scsi/scsi_pm.c   |  22 +++++++-
 drivers/scsi/scsi_priv.h |   3 ++
 drivers/scsi/sd.c        | 110 +++++++++++++++++++++++----------------
 4 files changed, 103 insertions(+), 46 deletions(-)

-- 
2.21.0.196.g041f5ea1cf98

