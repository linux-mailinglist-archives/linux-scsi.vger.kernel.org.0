Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5622222200
	for <lists+linux-scsi@lfdr.de>; Sat, 18 May 2019 09:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfERHQb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 18 May 2019 03:16:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:3049 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfERHQb (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 18 May 2019 03:16:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 May 2019 00:16:30 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 May 2019 00:16:29 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hRta0-000968-JH; Sat, 18 May 2019 15:16:28 +0800
Date:   Sat, 18 May 2019 15:15:41 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Cc:     kbuild-all@01.org, linux-scsi@vger.kernel.org,
        suganath-prabu.subramani@gmail.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: Re: [PATCH 01/10] mpt3sas: function pointers of request descriptor
Message-ID: <201905181542.wxLZ1iV2%lkp@intel.com>
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

Hi Suganath,

I love your patch! Perhaps something to improve:

[auto build test WARNING on scsi/for-next]
[also build test WARNING on v5.1 next-20190517]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Suganath-Prabu-S/mpt3sas-Aero-Sea-HBA-feature-addition/20190518-092803
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/scsi/mpt3sas/mpt3sas_base.c:1515:64: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got id volatile [noderef] <asn:2> *addr @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:1515:64: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/scsi/mpt3sas/mpt3sas_base.c:1515:64: sparse:    got unsigned long long [usertype] *
   drivers/scsi/mpt3sas/mpt3sas_base.c:1569:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got id volatile [noderef] <asn:2> *addr @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:1569:52: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/scsi/mpt3sas/mpt3sas_base.c:1569:52: sparse:    got unsigned long long [usertype] *
>> drivers/scsi/mpt3sas/mpt3sas_base.c:3539:1: sparse: sparse: symbol '_base_put_smid_fast_path' was not declared. Should it be static?
>> drivers/scsi/mpt3sas/mpt3sas_base.c:3562:1: sparse: sparse: symbol '_base_put_smid_hi_priority' was not declared. Should it be static?
>> drivers/scsi/mpt3sas/mpt3sas_base.c:3625:1: sparse: sparse: symbol '_base_put_smid_default' was not declared. Should it be static?
   drivers/scsi/mpt3sas/mpt3sas_base.c:5317:24: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int val @@    got restricted __le3unsigned int val @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:5317:24: sparse:    expected unsigned int val
   drivers/scsi/mpt3sas/mpt3sas_base.c:5317:24: sparse:    got restricted __le32 [usertype]
   drivers/scsi/mpt3sas/mpt3sas_base.c:5336:20: sparse: sparse: cast to restricted __le16
   drivers/scsi/mpt3sas/mpt3sas_base.c:5344:20: sparse: sparse: cast to restricted __le16
   drivers/scsi/mpt3sas/mpt3sas_base.c:5357:36: sparse: sparse: cast to restricted __le16
   drivers/scsi/mpt3sas/mpt3sas_base.c:6442:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got id volatile [noderef] <asn:2> *addr @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:6442:55: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/scsi/mpt3sas/mpt3sas_base.c:6442:55: sparse:    got unsigned long long [usertype] *

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
