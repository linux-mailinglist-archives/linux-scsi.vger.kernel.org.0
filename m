Return-Path: <linux-scsi+bounces-20544-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC6qAO/qdmkjYwEAu9opvQ
	(envelope-from <linux-scsi+bounces-20544-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Jan 2026 05:17:51 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E7983D4F
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Jan 2026 05:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EFE43006501
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Jan 2026 04:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFA829A33E;
	Mon, 26 Jan 2026 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WdPh0p1R"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A59E3EBF2D;
	Mon, 26 Jan 2026 04:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769401065; cv=none; b=JP5yaShq8sI0X66U5JgpfUyCL0xdKhe+T1qc29VtVUUtPWunyG51nxp4IhdPyRjQDdiQo3niVxCFXyE2pi0/HS3Sn5j4LVhr5AliGUd+9dCctzadG4G/NIYo3NhhJWuMXoOD6hz9IThO5PLhpq85tHDr4HjH7zk3wCqci77s+YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769401065; c=relaxed/simple;
	bh=DWZ+zP/o+PNSV1Ca2XQ1KKvlddtKK0JFY+YM1EtEhz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N83Cc+ds6sYyGxn1OYp+kswARWUdX7PhX8xQIaNdLlJieMevsbj7ne0HJbTYnM/7DTF4vdysk72eNyhYTiGNPhQTbMj4hi8cPcQE4KE0Yjc+0oJIn74ZXWw97bdCl9xrKDMTEEDoSfYkWeLHFSa0oANMP0RT0phEXT4lSVVUPFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WdPh0p1R; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769401063; x=1800937063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DWZ+zP/o+PNSV1Ca2XQ1KKvlddtKK0JFY+YM1EtEhz8=;
  b=WdPh0p1R1HbklSpxUr5ZDlrBNk1LvfQdSCrOw25on3s2DhFHOFA2Tm2L
   abA/lEu9jCv05iKF/Urj00sln+X+7iCDYC45fh6VGLcmiNqiFS8ohLnRG
   tyjv/pgWb7aCjWJ/QmBm+tMn8uPy12en+55lzkQnrzRoKrY59pDf8a3US
   DhqgIcWOVk3SUFPqNwFjnyZRdViDq6TZ5YFWpbJYPztSMsTWv5jqvzgDK
   ckWCPDCc6fiQoGxDtnDrEhGieNCyughf3UvaCa8KYUva7ILLe1HVbgGSj
   CYJsLk6zcPAxGugQN8zvZSU6tZEvE6+rr60oxBMdWNzJ+83XrgLOZa+Iq
   A==;
X-CSE-ConnectionGUID: DL+nVYwlRfiDojWsYNVgdg==
X-CSE-MsgGUID: rYX4Fh5fTzGo+65tg8MCvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="58154488"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="58154488"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2026 20:17:43 -0800
X-CSE-ConnectionGUID: ww/ezrmCQ8uTtHlfDIpmNg==
X-CSE-MsgGUID: zDSOzlbFSp+iCBosbAWMkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="212090609"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 25 Jan 2026 20:17:41 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkE2j-00000000Wsk-1w9l;
	Mon, 26 Jan 2026 04:17:37 +0000
Date: Mon, 26 Jan 2026 12:17:16 +0800
From: kernel test robot <lkp@intel.com>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: oe-kbuild-all@lists.linux.dev, MPT-FusionLinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Subject: Re: [PATCH] scsi: mpt3sas: fix a potential memory leak in
 scsih_pci_slot_reset()
Message-ID: <202601261249.g2g6MMxT-lkp@intel.com>
References: <20260125161201.2156109-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125161201.2156109-1-lihaoxiang@isrc.iscas.ac.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-20544-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-scsi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,01.org:url,git-scm.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06E7983D4F
X-Rspamd-Action: no action

Hi Haoxiang,

kernel test robot noticed the following build errors:

[auto build test ERROR on jejb-scsi/for-next]
[also build test ERROR on mkp-scsi/for-next linus/master v6.19-rc7 next-20260123]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haoxiang-Li/scsi-mpt3sas-fix-a-potential-memory-leak-in-scsih_pci_slot_reset/20260126-001420
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
patch link:    https://lore.kernel.org/r/20260125161201.2156109-1-lihaoxiang%40isrc.iscas.ac.cn
patch subject: [PATCH] scsi: mpt3sas: fix a potential memory leak in scsih_pci_slot_reset()
config: arm-randconfig-002-20260126 (https://download.01.org/0day-ci/archive/20260126/202601261249.g2g6MMxT-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260126/202601261249.g2g6MMxT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601261249.g2g6MMxT-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/scsi/mpt3sas/mpt3sas_scsih.c: In function 'scsih_pci_slot_reset':
>> drivers/scsi/mpt3sas/mpt3sas_scsih.c:12533:9: error: implicit declaration of function 'mpt3sas_base_unmap_resources'; did you mean 'mpt3sas_base_map_resources'? [-Werror=implicit-function-declaration]
   12533 |         mpt3sas_base_unmap_resources(ioc);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         mpt3sas_base_map_resources
   cc1: some warnings being treated as errors


vim +12533 drivers/scsi/mpt3sas/mpt3sas_scsih.c

 12496	
 12497	/**
 12498	 * scsih_pci_slot_reset - Called when PCI slot has been reset.
 12499	 * @pdev: PCI device struct
 12500	 *
 12501	 * Description: This routine is called by the pci error recovery
 12502	 * code after the PCI slot has been reset, just before we
 12503	 * should resume normal operations.
 12504	 */
 12505	static pci_ers_result_t
 12506	scsih_pci_slot_reset(struct pci_dev *pdev)
 12507	{
 12508		struct Scsi_Host *shost;
 12509		struct MPT3SAS_ADAPTER *ioc;
 12510		int rc;
 12511	
 12512		if (_scsih_get_shost_and_ioc(pdev, &shost, &ioc))
 12513			return PCI_ERS_RESULT_DISCONNECT;
 12514	
 12515		ioc_info(ioc, "PCI error: slot reset callback!!\n");
 12516	
 12517		ioc->pci_error_recovery = 0;
 12518		ioc->pdev = pdev;
 12519		pci_restore_state(pdev);
 12520		rc = mpt3sas_base_map_resources(ioc);
 12521		if (rc)
 12522			return PCI_ERS_RESULT_DISCONNECT;
 12523	
 12524		ioc_info(ioc, "Issuing Hard Reset as part of PCI Slot Reset\n");
 12525		rc = mpt3sas_base_hard_reset_handler(ioc, FORCE_BIG_HAMMER);
 12526	
 12527		ioc_warn(ioc, "hard reset: %s\n",
 12528			 (rc == 0) ? "success" : "failed");
 12529	
 12530		if (!rc)
 12531			return PCI_ERS_RESULT_RECOVERED;
 12532	
 12533		mpt3sas_base_unmap_resources(ioc);
 12534		return PCI_ERS_RESULT_DISCONNECT;
 12535	}
 12536	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

