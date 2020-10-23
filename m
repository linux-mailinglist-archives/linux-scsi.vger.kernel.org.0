Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B1F297889
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Oct 2020 22:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755527AbgJWU5e (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Oct 2020 16:57:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:41942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755398AbgJWU5e (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 23 Oct 2020 16:57:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4E216AD1E;
        Fri, 23 Oct 2020 20:57:33 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org
Subject: [PATCH 0/5] scsi: target: COMPARE AND WRITE miscompare sense
Date:   Fri, 23 Oct 2020 22:57:18 +0200
Message-Id: <20201023205723.17880-1-ddiss@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patchset adds missing functionality to return the offset of
non-matching read/compare data in the sense INFORMATION field on
COMPARE AND WRITE miscompare.

The functionality can be tested using the libiscsi
CompareAndWrite.MiscompareSense test proposed via:
  https://github.com/sahlberg/libiscsi/pull/344

Cheers, David

 drivers/target/target_core_sbc.c       | 134 +++++++++++++++----------
 drivers/target/target_core_transport.c |  33 +++---
 include/target/target_core_base.h      |   2 +-
 lib/scatterlist.c                      |   2 +-
 4 files changed, 102 insertions(+), 69 deletions(-)


