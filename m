Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADB3597EA
	for <lists+linux-scsi@lfdr.de>; Fri, 28 Jun 2019 11:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfF1JvR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 28 Jun 2019 05:51:17 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:41276 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfF1JvR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 28 Jun 2019 05:51:17 -0400
Received: by mail-pg1-f177.google.com with SMTP id q4so877102pgj.8
        for <linux-scsi@vger.kernel.org>; Fri, 28 Jun 2019 02:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YwYOSHhKqL2V8VaSIWY/HLQqXyDe9+j81Kj3CzYdKRw=;
        b=daTekRFQK1GWPhQBKesObC8lSzwbGEIAMFyL8pLBlRRzSYA9uAufW8wPYHQlvabxU1
         c0S9ca88H88Mv7wM3jnDF6d2g5x+p15dZChzPbHdEq2WDv/ShO6XEpfL9n7DEYrXaEs4
         f8KMiyRcPYFtPvxVNDzKW0cZxEGJh5A+nWCj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YwYOSHhKqL2V8VaSIWY/HLQqXyDe9+j81Kj3CzYdKRw=;
        b=olxwag1iPbar/SQwb5rKsIloAbmxeApVgubn/Gd5UbCLPE0MhuNN4pwHmnhWCDFxg8
         NWKQA/2aI3u6NvTEEhlRT/7JfyIMfav0uwTbkcAm7J1R7PfEnnOgS5sqTWCWI4s46JXJ
         QvjQxfijik9xyBF8T2jb3eRqr1DsGxmn9NWr0dIjTwz7wC4n9zdtsvqwtDHRp1og/eWH
         x2iGN2Ai7/yBiLiozH6SPcnXoH21k/vUNtxD+VvcmPkZW+sbcLmJDpMJkpm9d9QyPwf7
         uS/9cOQ4SodaxTTNnEKjKUzb6X0vNjnRZudi2IPryzVOz3wBCTxjc9rbwfMccEIpwWJl
         szjQ==
X-Gm-Message-State: APjAAAWzD788mJkF3nIkY6Ast7pl74JmctMFbk3AZZS759/83AuNvdnJ
        oqGIe2vZBUJjEeQuKe6yzUf5KP+UCH+EBIX6AeHRwkCHk+EKB6iefnZjLC9buHQIo0uxFfn6JXs
        s0NFML4USEzsE78pD2V+m6VgDgPReEZ9ANFaNsfYlQzssFG9GH6LgmDNOnKi+rzp/B5MXDca8zs
        a4gFvVjFiQgUQcNvpyo2SZlXI=
X-Google-Smtp-Source: APXvYqzjlg/2yNkR207tjWvzEK180okLsds4rzUI7zmY3dQP0pTUqshf3M5th6THf0Dx7kMdnEGfpg==
X-Received: by 2002:a17:90a:cb8e:: with SMTP id a14mr11842811pju.124.1561715476034;
        Fri, 28 Jun 2019 02:51:16 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q19sm2096975pfc.62.2019.06.28.02.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:51:15 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, chandrakanth.patil@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH 0/4] megaraid_sas: driver updates
Date:   Fri, 28 Jun 2019 02:50:37 -0700
Message-Id: <1561715441-1428-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,
This series contains four driver update patches.
The first patch contains a fix for calculating the target ID
sent to firmware. This patch was sent earlier as well[1], but
got lost in the v2 series due to a mail client issue.
Second patch enables newly added "msix_load_balance" flag
only for Invader and later generation controllers.
Third patch adds a module parameter which controls logging
of async event notifications from firmware.
Fourth patch updates the driver version.
Please consider these patches for 5.3/scsi-queue.

[1]: https://www.spinics.net/lists/stable/msg299673.html

Thanks,
Shivasharan
 
Shivasharan S (4):
  megaraid_sas: Fix calculation of target ID
  megaraid_sas: Enable msix_load_balance for Invader and later
    controllers
  megaraid_sas: Add module parameter for FW Async event logging
  megaraid_sas: Update driver version to 07.710.50.00

 drivers/scsi/megaraid/megaraid_sas.h      |  4 ++--
 drivers/scsi/megaraid/megaraid_sas_base.c | 24 +++++++++++++++++++++---
 2 files changed, 23 insertions(+), 5 deletions(-)

-- 
2.9.5

