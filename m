Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 713C054D20
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 13:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfFYLEx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 07:04:53 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:43562 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfFYLEx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 25 Jun 2019 07:04:53 -0400
Received: by mail-pf1-f178.google.com with SMTP id i189so9289163pfg.10
        for <linux-scsi@vger.kernel.org>; Tue, 25 Jun 2019 04:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VAzkzMj+ttT7//234Y7wRQZo8RYoVgeqRiSazKkmg9E=;
        b=YQhX9BvIHhLAQXszkvry8YHdopQVR7X+1CV36fZYucNzdvHKSh+yorqqEBswQ0sUe1
         u0CwwKpCs1vDRyEuRroWthPkhy3OlIlYXIQuFTi1xPet5+T/a7wcbH9bw7i1Rd44mBLn
         6UkHQjh1ZRV0n0LkbdM0aoanioHA+5T/pS1x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VAzkzMj+ttT7//234Y7wRQZo8RYoVgeqRiSazKkmg9E=;
        b=pHlG8SJy6Cjjwp/1dwwQz4nK4e55baGUu2iWrjF5BpQdKaGqpykk9ICIsa/00N8eQv
         QLxsBkRyGTH6DxuSwvZbcNwuVkgQXW+QBzJyKB8uD0K8gsuH39gK2WMJGWGjdVVOWk0W
         TJCFven2yINWu89joeeTH5IkOS4vnQS//0H7pixnLOuxjS8ueU5eHFpkqJ4mNdK4PDoK
         aV+xw262Yv4hvXT7I+ZrS5FRzCU7aNFecN+xzsDqq/DrsujXGkN4uYp79h1K2RhizvK5
         FZAOjlsqfkZaoFhoX1J/S7ZuO9MODCpRMy1Yv8J9P+oTmIhSzmmIawdJVaXqDOjkxf4E
         2u9A==
X-Gm-Message-State: APjAAAUMPruIVNvIC7zkW9MX7l/RXKdPNKpMtVkXIeNQ5DvDvjWCh+xW
        hkJRJ1CWcQXqpaFGc6hErI6YP2c1Rt656hJdalrX7AYw5pl755pnle+sQuP8b6nVNiDMk60hz7u
        b6CkLfGPAB6h5axD6iaGxRkHU1PZcqs1ijRouNe2AyOyy/IQaP5A/Y+c9zpYtSTN7qZR+RI5Sb9
        qmtaSavryRsH6M
X-Google-Smtp-Source: APXvYqwRPuLh9TJLzIrmXdCx98L73mGR1ZovPoGIabGjKGgG8lX9eyXvMKL/NZN6GY2iXfLPh9OWlQ==
X-Received: by 2002:a63:78c3:: with SMTP id t186mr39473994pgc.340.1561460692327;
        Tue, 25 Jun 2019 04:04:52 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t5sm14757389pgh.46.2019.06.25.04.04.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 04:04:51 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        anand.lodnoor@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v3 00/18] megaraid_sas: driver updates to 07.710.06.00-rc1
Date:   Tue, 25 Jun 2019 16:34:18 +0530
Message-Id: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patchset contains performance improvements in megaraid_sas driver
for latest MegaRAID Aero family of adapters along with few driver fixes.
  
V2:
    - Fixed sparse warnings reported by kbuild test robot in patch 11.
    - Fixed module parameter description in patch 17.

V3:
    - Fixed smatch warning reported by Dan Carpenter <dan.carpenter@oracle.com> in patch 17
				
Chandrakanth Patil (18):
  megaraid_sas: Add 32 bit atomic descriptor support to AERO adapters
  megaraid_sas: Add support for Non-secure Aero PCI IDs
  megaraid_sas: Remove few debug counters from IO path
  megaraid_sas: Call disable_irq from process IRQ poll
  megaraid_sas: Release Mutex lock before OCR in case of DCMD timeout
  megaraid_sas: In probe context, retry IOC INIT once if firmware is in
    fault
  megaraid_sas: Don't send FPIO to RL Bypass queue
  megaraid_sas: Handle sequence JBOD map failure at driver level
  megaraid_sas: megaraid_sas: Add check for count returned by
    HOST_DEVICE_LIST DCMD
  megaraid_sas: RAID1 PCI bandwidth limit algorithm is applicable for
    only Ventura
  megaraid_sas: Offload Aero RAID5/6 division calculations to driver
  megaraid_sas: Add support for MPI toolbox commands
  megaraid_sas: Add support for High IOPs queues
  megaraid_sas: Enable coalescing for high IOPs queues
  megaraid_sas: Set affinity for high IOPs reply queues
  megaraid_sas: Use high IOPs queues based on IO workload
  megaraid_sas: Introduce various Aero performance modes
  megaraid_sas: Update driver version to 07.710.06.00-rc1

 drivers/scsi/megaraid/megaraid_sas.h        |  78 +++++++-
 drivers/scsi/megaraid/megaraid_sas_base.c   | 300 +++++++++++++++++++++++++---
 drivers/scsi/megaraid/megaraid_sas_fp.c     |  79 ++++++++
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 248 ++++++++++++++++-------
 drivers/scsi/megaraid/megaraid_sas_fusion.h |  27 ++-
 5 files changed, 623 insertions(+), 109 deletions(-)

-- 
2.9.5

