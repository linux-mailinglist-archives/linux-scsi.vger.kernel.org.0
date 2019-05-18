Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E04E7221FF
	for <lists+linux-scsi@lfdr.de>; Sat, 18 May 2019 09:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfERHQb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 18 May 2019 03:16:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:13635 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbfERHQa (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 18 May 2019 03:16:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 May 2019 00:16:30 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 18 May 2019 00:16:29 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hRta0-00093n-I3; Sat, 18 May 2019 15:16:28 +0800
Date:   Sat, 18 May 2019 15:15:44 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Cc:     kbuild-all@01.org, linux-scsi@vger.kernel.org,
        suganath-prabu.subramani@gmail.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [RFC PATCH] mpt3sas: _base_put_smid_fast_path can be static
Message-ID: <20190518071544.GA20877@lkp-kbuild18>
References: <20190517145905.4765-2-suganath-prabu.subramani@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517145905.4765-2-suganath-prabu.subramani@broadcom.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Fixes: 0f30229824bc ("mpt3sas: function pointers of request descriptor")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 mpt3sas_base.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index f8bdb45..ab0392a 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3535,7 +3535,7 @@ _base_put_smid_scsi_io(struct MPT3SAS_ADAPTER *ioc, u16 smid, u16 handle)
  * @smid: system request message index
  * @handle: device handle
  */
-void
+static void
 _base_put_smid_fast_path(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 	u16 handle)
 {
@@ -3558,7 +3558,7 @@ _base_put_smid_fast_path(struct MPT3SAS_ADAPTER *ioc, u16 smid,
  * @smid: system request message index
  * @msix_task: msix_task will be same as msix of IO incase of task abort else 0.
  */
-void
+static void
 _base_put_smid_hi_priority(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 	u16 msix_task)
 {
@@ -3621,7 +3621,7 @@ mpt3sas_base_put_smid_nvme_encap(struct MPT3SAS_ADAPTER *ioc, u16 smid)
  * @ioc: per adapter object
  * @smid: system request message index
  */
-void
+static void
 _base_put_smid_default(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 {
 	Mpi2RequestDescriptorUnion_t descriptor;
