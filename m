Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81627486D0
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 17:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfFQPS2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 11:18:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39926 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfFQPS2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 17 Jun 2019 11:18:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so4217767pls.6
        for <linux-scsi@vger.kernel.org>; Mon, 17 Jun 2019 08:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dAEprVlik947Z0GowRYMuMDRNA1UggBt8wtL81khw3k=;
        b=GjqsJXjqFi/Op0meAijmHkjN7Tn2zt+v8cA4V1nAkcJ77PNI0eGy9sInghkSHLU+Tj
         83mWk/CB34DZ6kYmnQgGK/U300vFQ2ohZ9sRlwQkmQz01G/Ud//0QyH+JnrrSUzoHHYy
         wSJE12nmooDz2hpJ/q2V+iDH4BDHDSuKJfCXPIo0YY1NFD+GTZk5ckJva0GtKfWOa5uN
         0RvF0F50bgM3URxqLerRyNPCMPwxaWfid8O1+xoAcOG22KVLM3YgHr97+dIb076hgAtb
         ddti1yslzj+7v6QVq+rzUil5lpOmvs4tNSdGGUya+zMxoWFlOurDhxaqGwyeEenI8vmf
         1pIA==
X-Gm-Message-State: APjAAAVegvbE82/ZSTnA2O0NZGSz/0IhY8itgZsZ1uCiFXRP5sIsAsuj
        PORyMn060T1JvMVgAgr4shM=
X-Google-Smtp-Source: APXvYqzJpjYxpYs9vX3rE8X73VkL7N4YNUbZG256uBqp/laNK3FaiFeYWRx2Bxo/IpDRzYVahMvU9Q==
X-Received: by 2002:a17:902:ba82:: with SMTP id k2mr101927301pls.323.1560784707799;
        Mon, 17 Jun 2019 08:18:27 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id n5sm12529949pgd.26.2019.06.17.08.18.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 08:18:26 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 0/3] Avoid that .queuecommand() gets called for a quiesced SCSI device
Date:   Mon, 17 Jun 2019 08:18:17 -0700
Message-Id: <20190617151820.241583-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

As explained in a recent LSF/MM topic proposal, it can happen that the SCSI
error handler calls .queuecommand() for a blocked SCSI device. SCSI LLDs do
not expect this. Hence this patch series. Please consider this series for
kernel v5.3.

Thanks,

Bart.

Changes compared to v3:
- Instead of converting sysfs attempts to change the SCSI device state into
  "blocked" into "quiesced", refuse attempts to change the SCSI device into
  anything else than "offline" or "running".
- In patch 2/2, remove a "to do" comment above scsi_internal_device_block().

Changes compared to v2:
- Added a patch that converts SDEV_BLOCK into SDEV_QUIESCE for requests
  received through sysfs to change the SCSI device state.

Changes compared to v1:
- Wait on SDEV_BLOCK instead of SDEV_QUIESCE in the SCSI error handler.

Bart Van Assche (3):
  scsi: Restrict user space SCSI device state changes to "running" and
    "offfline"
  scsi: Avoid that .queuecommand() gets called for a blocked SCSI device
  RDMA/srp: Fix a sleep-in-invalid-context bug

 drivers/infiniband/ulp/srp/ib_srp.c | 21 ++-------------------
 drivers/scsi/scsi_error.c           | 26 ++++++++++++++++++++++++--
 drivers/scsi/scsi_lib.c             |  4 ----
 drivers/scsi/scsi_sysfs.c           |  7 ++++++-
 4 files changed, 32 insertions(+), 26 deletions(-)

-- 
2.22.0.rc3

