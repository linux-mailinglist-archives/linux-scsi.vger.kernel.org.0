Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00D354CC4E
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 12:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfFTKwk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 06:52:40 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:41362 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFTKwk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 06:52:40 -0400
Received: by mail-pf1-f182.google.com with SMTP id m30so1447733pff.8
        for <linux-scsi@vger.kernel.org>; Thu, 20 Jun 2019 03:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BSOdULpbkE05708aEyRxxlR9yWrgl4/OoS9VtFNRUcY=;
        b=TXRFKbIXCg0v6FMZd/MyQUr0IaRvYMhGGI9U1kZPcq2Hvh8Y4Xv8o6rGj3Y9ax1TAu
         svCVu5MKCUMqV5Ao3kX4joklHYzfg+Wn1DXcoUrKmJEJqkOroPyR/x5KJPgHLtQYEyTP
         YSIenW4lk638XNeBHor20W2xHflNU+rCg8ur0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BSOdULpbkE05708aEyRxxlR9yWrgl4/OoS9VtFNRUcY=;
        b=psX2FpMRFsexcqj6UzaoNq0YhwrG8By/WDBT7DJHLKG5pgwscPnu88hTIRc+ZLe5rX
         SDk3xegwfC6Pb0OekXNyhDImPBvI1OZ0NOj+aLU6w9RIfl6oaK+Y5vn6Qa7rV6td10E2
         Kc5KCK0Evj0zI2dH4NqFIZbWarpGLL4s220QdA+o/eMIu/mopQpPWnW2nz4VSl63iG6y
         N/GHbDgOmDMdwbfTTNGoKInBJq+fD7iFgmt/O6yqKBt3RLba+eyb1yIMQSbzwWnIudex
         MVzbEDuii/FM5QzMr8Z4fwmcdGa+CJFWrKjWsB8AVNo9oXulsKcthQNALIKhgwtsPud1
         p/kA==
X-Gm-Message-State: APjAAAXlaP1zGuMpZR9oYdr61XJWglzmGsLUwg76hUxpG745+a1l33Xr
        H6KfhZyz6kElhmASOElkJPVokTve8sNjAhkGa57bEa8c8Fr5c/WO3popsMfaSuZ3RmURnfsakRU
        4tacVJQ8XkIbxEhGZhpXvjUwtAPFUhWbSbP0B0e+TRFFFDNE9fH3CACzR3g01QWsAq7HFUCzBjq
        +96E6qKEwhzC8sA1c=
X-Google-Smtp-Source: APXvYqy6aP1D+sCQS5BxSE0b3yvFFDcEjpGK0PIgzxkxyFOE5UeYm4X5FzrIKgPtk5HetS70JdsWgQ==
X-Received: by 2002:a17:90a:cf0d:: with SMTP id h13mr2428299pju.63.1561027958970;
        Thu, 20 Jun 2019 03:52:38 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l7sm24793995pfl.9.2019.06.20.03.52.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 03:52:38 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v2 00/18] megaraid_sas: driver updates to 07.710.06.00-rc1
Date:   Thu, 20 Jun 2019 16:21:50 +0530
Message-Id: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
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

