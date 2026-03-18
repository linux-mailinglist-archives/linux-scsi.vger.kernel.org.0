Return-Path: <linux-scsi+bounces-22195-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL4aK3DeumlScwIAu9opvQ
	(envelope-from <linux-scsi+bounces-22195-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Mar 2026 18:18:40 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 591EC2C018E
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Mar 2026 18:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4DA11300CA07
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Mar 2026 17:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BBE2BE04C;
	Wed, 18 Mar 2026 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1/Bxw2J"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A414481DD;
	Wed, 18 Mar 2026 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773854308; cv=none; b=JPgOrW/+sRj0zZ9/wkmaRucEzG/vJgie8bTBsBMXx86kFz2SEDP4jAPbRI6qnufZEuJytjaroIOCGf+7JnXWPTGJs1JWkLrBoOiaZk/r9dvv8oBxwq6unfj8O04GIqM4r9dGVljPexu2qxk84sUx9DCWG0PMaJoV2yD3heuBmsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773854308; c=relaxed/simple;
	bh=tcwBnr4PB39Z0VvfyqpTv96JTqTKA7HJd/AGMFQzpNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opTtzb13N+OOlli5EHxZGpjdqfnJb/Suyyi5StoL/jc/z4U8l162LmZ1aFCmiBdHmWXdDN41cG1lZJTVHNvfsqZED21U74HKhNexM6KfkRUqmNjj++haMCeqt++8DxT8NResTbAjBAwGOECpVeCP8iK4wDFcVnmtwjPp/XvS4N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1/Bxw2J; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773854307; x=1805390307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tcwBnr4PB39Z0VvfyqpTv96JTqTKA7HJd/AGMFQzpNE=;
  b=N1/Bxw2Jls0Wfx60V7+SXdvJ8Roh8foe+9nnJpDtqvkOATmYMMArn9dl
   YQ8CEC3npkEyjE3rn4WJsiSMd4Tr8+NFb4zareZ6b7Puz9P6NnS8876AC
   EmYW0HjAxzswbO4Wb8w1vZDO7fqhwn7b1nZn8FiG2MhEr3yTZfl0UgbgW
   PR+321TUpIDozf7ITeL6sIUBvHFM1rgNVKNvPgvYZF/u4WIpiMGdhHWIc
   SIhgYRaGU2/+BG3vFkKk5mxXv66P/yDS2lWXpY/ih5SoaOrbjWrQu+iI4
   vEyipNgz3IBXyxSuEjJKl9VDwgcyo3ysrJ9xP5qRj+u5NXW0EcprEzyO/
   Q==;
X-CSE-ConnectionGUID: /EjCdJvxQWiEpJQsalH5fA==
X-CSE-MsgGUID: 3XKICSbJTHC7NRC4945CZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="78777252"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="78777252"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 10:18:26 -0700
X-CSE-ConnectionGUID: VjFluSBYSA6w+OIZxsFQjw==
X-CSE-MsgGUID: FxqhJ4nVRnKXPpe36MzK0Q==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 63737dd503cb) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 18 Mar 2026 10:18:24 -0700
Received: from kbuild by 63737dd503cb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2uXC-000000003BZ-2GZk;
	Wed, 18 Mar 2026 17:18:18 +0000
Date: Thu, 19 Mar 2026 01:17:24 +0800
From: kernel test robot <lkp@intel.com>
To: John Garry <john.g.garry@oracle.com>, martin.petersen@oracle.com,
	james.bottomley@hansenpartnership.com, hare@suse.com,
	bmarzins@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, jmeneghi@redhat.com,
	linux-scsi@vger.kernel.org, michael.christie@oracle.com,
	snitzer@kernel.org, dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH 02/13] scsi: alua: Create a core ALUA driver
Message-ID: <202603190113.JzA11dmp-lkp@intel.com>
References: <20260317120703.3702387-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317120703.3702387-3-john.g.garry@oracle.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22195-lists,linux-scsi=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 591EC2C018E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi John,

kernel test robot noticed the following build errors:

[auto build test ERROR on mkp-scsi/for-next]
[also build test ERROR on jejb-scsi/for-next linus/master v7.0-rc4 next-20260317]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Garry/scsi-scsi_dh_alua-Delete-alua_port_group/20260318-105207
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20260317120703.3702387-3-john.g.garry%40oracle.com
patch subject: [PATCH 02/13] scsi: alua: Create a core ALUA driver
config: s390-randconfig-001-20260318 (https://download.01.org/0day-ci/archive/20260319/202603190113.JzA11dmp-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260319/202603190113.JzA11dmp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603190113.JzA11dmp-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "scsi_exit_alua" [drivers/scsi/scsi_mod.ko] undefined!
>> ERROR: modpost: "scsi_alua_init" [drivers/scsi/scsi_mod.ko] undefined!
>> ERROR: modpost: "scsi_alua_sdev_exit" [drivers/scsi/scsi_mod.ko] undefined!
>> ERROR: modpost: "scsi_alua_sdev_init" [drivers/scsi/scsi_mod.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

