Return-Path: <linux-scsi+bounces-22206-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOXTOA4xu2kEggIAu9opvQ
	(envelope-from <linux-scsi+bounces-22206-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Mar 2026 00:11:10 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 512702C3BE2
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Mar 2026 00:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E228731187B6
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Mar 2026 23:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214EF345753;
	Wed, 18 Mar 2026 23:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DrD6Y/gW"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4C9314A8E;
	Wed, 18 Mar 2026 23:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773875419; cv=none; b=k5W3O+qJ5+s5lW/2aUfGO/5LgQisBwJxTU9xf8FsUAMKlptaRJkEuZ/1Al9cPzGRoP/QDG1q9m7ugJjefzkuZrpwFoGn/yxEoZr1WNJ67IHnAGousg4xgMffRVM8OzoKHo1fLSoeIBIuOeGNemhjsUnH4/5DInjfnmpk0x94O1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773875419; c=relaxed/simple;
	bh=95Ql3WVZ8e0qOQZMKgmFQhFFemfGSunBs6ibeA/axrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c12mDeAR2zEHC4DrCMY3Rad9cZ8tMpozRF71+/rAO8534tyofqOAZl0hPA3CIf8qP4YG6swKM7I1KgVx7QQiGbHSEUEOIx/Pk7biNj1cJZcIVudgFyQr01AsE1qyljZ+dOqEahjneVX0XGUdFA8ZivoSLEy9T5O3j5HboyXon90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DrD6Y/gW; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773875419; x=1805411419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=95Ql3WVZ8e0qOQZMKgmFQhFFemfGSunBs6ibeA/axrQ=;
  b=DrD6Y/gWC/rYiFkNpESABdC1nWTKVLQO5GO4oQYeK0l34FqtsS5ox0yV
   zYIaX1ALaOWsWaH+tLC0HnbUcgzbqF+6u7SHTNHmMUbHQ1cUNioh9zP/U
   qfHa1xqDn2UZIMbMVnrSkTl0Y4fHgVnRBc1T+K5yPG7eHiHHFLxQdbxut
   74wBYwTRqTHtBn5QuR/1JptAxOu71QKyMlkx85HYZsBNA6gu/+CUhU9jO
   EGMHCienlp0gGv9LMCRKB4nptEWT+DairYHB4tUc3h7JA7RziDaDKRP8H
   iW16myE6Qt/e1pG5lE4e3+FrlqePOiuIcCGRzbo1/dmLBlcexDADm4xGI
   Q==;
X-CSE-ConnectionGUID: jm+zbvDBR42edSZ+eXiH0Q==
X-CSE-MsgGUID: 6IXaOpRWTy20kK6p/eLKUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74977614"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="74977614"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 16:10:19 -0700
X-CSE-ConnectionGUID: xz+BYbbPSeiNCchxVoNwjA==
X-CSE-MsgGUID: z9QQErIISTi2hhaF4QOeTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="226918699"
Received: from lkp-server02.sh.intel.com (HELO a51c2a36b9df) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 18 Mar 2026 16:10:15 -0700
Received: from kbuild by a51c2a36b9df with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w300R-00000000041-2VZN;
	Wed, 18 Mar 2026 23:09:23 +0000
Date: Thu, 19 Mar 2026 07:08:13 +0800
From: kernel test robot <lkp@intel.com>
To: John Garry <john.g.garry@oracle.com>, martin.petersen@oracle.com,
	james.bottomley@hansenpartnership.com, hare@suse.com,
	bmarzins@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, jmeneghi@redhat.com,
	linux-scsi@vger.kernel.org, michael.christie@oracle.com,
	snitzer@kernel.org, dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH 13/13] scsi: core: Add implicit ALUA support
Message-ID: <202603190739.QIFfPfdg-lkp@intel.com>
References: <20260317120703.3702387-14-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317120703.3702387-14-john.g.garry@oracle.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22206-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-scsi];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url,git-scm.com:url]
X-Rspamd-Queue-Id: 512702C3BE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi John,

kernel test robot noticed the following build errors:

[auto build test ERROR on mkp-scsi/for-next]
[also build test ERROR on jejb-scsi/for-next linus/master v7.0-rc4 next-20260318]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Garry/scsi-scsi_dh_alua-Delete-alua_port_group/20260318-105207
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20260317120703.3702387-14-john.g.garry%40oracle.com
patch subject: [PATCH 13/13] scsi: core: Add implicit ALUA support
config: s390-randconfig-001-20260318 (https://download.01.org/0day-ci/archive/20260319/202603190739.QIFfPfdg-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260319/202603190739.QIFfPfdg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603190739.QIFfPfdg-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "scsi_device_alua_rescan" [drivers/scsi/scsi_mod.ko] undefined!
>> ERROR: modpost: "scsi_alua_check_sense" [drivers/scsi/scsi_mod.ko] undefined!
ERROR: modpost: "scsi_exit_alua" [drivers/scsi/scsi_mod.ko] undefined!
ERROR: modpost: "scsi_alua_init" [drivers/scsi/scsi_mod.ko] undefined!
ERROR: modpost: "scsi_alua_sdev_exit" [drivers/scsi/scsi_mod.ko] undefined!
ERROR: modpost: "scsi_alua_sdev_init" [drivers/scsi/scsi_mod.ko] undefined!
>> ERROR: modpost: "scsi_device_alua_implicit" [drivers/scsi/scsi_mod.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

