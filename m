Return-Path: <linux-scsi+bounces-21167-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GuzJ9Frn2lEbwQAu9opvQ
	(envelope-from <linux-scsi+bounces-21167-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Feb 2026 22:38:25 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA95019DE5A
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Feb 2026 22:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41F83304C4A8
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Feb 2026 21:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F62626B2CE;
	Wed, 25 Feb 2026 21:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JowOInYQ"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9583330E847
	for <linux-scsi@vger.kernel.org>; Wed, 25 Feb 2026 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055502; cv=none; b=jh9HEvjJKJ4en/6Vunkfuj1tnhs/KSlJ02FL9vK2Csw8wftH5mc05Vj2tZMNk44R3vbVZLGjh6tbEelZyp9TteT4vLg5RyXfQHyp0eX2yvX78rP1uS5GlGXS6sYrDOpSd96+3CdMTUbOUSKzVD7o4GQF3miCjeusc83O6FpS42Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055502; c=relaxed/simple;
	bh=Wk4UoQl72s+9QTyqX2dBCxC919tJAENrmFZzVWmpIdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8mrgcl6u+vWvsTdi9p5emsblneY3hUS2tWJPrxR1nYpp0NFTvrqsLHk2JCh+xdjv8Q1AE8z5Fp32svccQGH5p9/47wSETPc4mHAEWLLtJDOHwrggZugckgCGJ5EN1LTivxYRXdmzNyXQFy9C+bj/9SjUB7G6KxY0crDEK+CgcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JowOInYQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772055500; x=1803591500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wk4UoQl72s+9QTyqX2dBCxC919tJAENrmFZzVWmpIdo=;
  b=JowOInYQ6mzhj9vlEvZk9XIReyxP3Szl7/6CAh9dunkRocrW/Y3ZewYb
   dX2wzG9AbCDoYeA58C+yPSD5ur2kCcC5fqnVGUx5yDn3LH9dS3eLT5ChO
   wEabnUHsLDgnqee9Zcmf0AoMEM7IXxEA26A/fHaUitaIQUFDQB5dYE0lg
   p+eIIuth5ldkyacy9/zni3tIZ3tOeGbNLRU9E2FZhbX2CqbCaysxJSdgG
   dkhzjkZ29sSgzwQFBmieZhKZbqnXFbhMbe92y6V6/mEhVRrt9IMOtHVT8
   aU1sHHXydso3HtUmRhYhImBllOX+Ng9SnkmNwz0PfKhaLolIC3U8T3J9b
   Q==;
X-CSE-ConnectionGUID: 4xv7rBOPRqqRF6RiACdbNw==
X-CSE-MsgGUID: paXicLhbSvueZ3Lp8hqe2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73016681"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="73016681"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 13:38:20 -0800
X-CSE-ConnectionGUID: KFgPQ3ZMTa+oDBHD7CnioA==
X-CSE-MsgGUID: eykxMU/JSo+bRXLMIY+0xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="244052943"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 25 Feb 2026 13:38:17 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvMZq-000000007Qn-2ucw;
	Wed, 25 Feb 2026 21:37:54 +0000
Date: Thu, 26 Feb 2026 05:37:12 +0800
From: kernel test robot <lkp@intel.com>
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, hch@lst.de, hare@suse.de,
	chaitanyak@nvidia.com, bvanassche@acm.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	James.Bottomley@hansenpartnership.com, mlombard@arkamax.eu,
	jmeneghi@redhat.com, emilne@redhat.com, bgurney@redhat.com
Subject: Re: [PATCH V3 2/3] nvme-core: register namespaces in order during
 async scan
Message-ID: <202602260543.EHcJPG8y-lkp@intel.com>
References: <20260225161203.76168-3-mlombard@redhat.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225161203.76168-3-mlombard@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21167-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-scsi];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: EA95019DE5A
X-Rspamd-Action: no action

Hi Maurizio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jejb-scsi/for-next]
[also build test WARNING on mkp-scsi/for-next linus/master v7.0-rc1 next-20260225]
[cannot apply to linux-nvme/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maurizio-Lombardi/lib-Introduce-completion-chain-helper/20260226-001842
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
patch link:    https://lore.kernel.org/r/20260225161203.76168-3-mlombard%40redhat.com
patch subject: [PATCH V3 2/3] nvme-core: register namespaces in order during async scan
config: x86_64-randconfig-161-20260226 (https://download.01.org/0day-ci/archive/20260226/202602260543.EHcJPG8y-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260226/202602260543.EHcJPG8y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602260543.EHcJPG8y-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/nvme/host/core.c:4117 struct member 'chain_entry' not described in 'async_scan_task'
>> Warning: drivers/nvme/host/core.c:4117 struct member 'chain_entry' not described in 'async_scan_task'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

