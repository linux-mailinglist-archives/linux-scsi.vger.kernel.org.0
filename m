Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4042ABC7F
	for <lists+linux-scsi@lfdr.de>; Mon,  9 Nov 2020 14:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbgKINiQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 9 Nov 2020 08:38:16 -0500
Received: from mga04.intel.com ([192.55.52.120]:33638 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732159AbgKINiH (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 9 Nov 2020 08:38:07 -0500
IronPort-SDR: aMO9BEQTWwIYHQ1GK0u+qB55l82JUsq/KF85FwpirvpVWRVns7bEeKGl56ernuYtYcFqQJ4+P9
 zvUKpj4DSYIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="167213977"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="167213977"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 05:38:07 -0800
IronPort-SDR: cW0DQ8Cq85vCcB1kn/lMGNkP0qA7b0TB6gTiFoxcFmOz/Q73B7l6Hf8cDA9YJZwlBPuENi0wHB
 6SboSGPIUyPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="307983684"
Received: from apaszkie-desk.igk.intel.com ([10.102.102.225])
  by fmsmga007.fm.intel.com with ESMTP; 09 Nov 2020 05:38:05 -0800
Subject: Re: [PATCH v1] scsi: isci: Don't use PCI helper functions
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Intel SCU Linux support <intel-linux-scu@intel.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201107100420.149521-1-vaibhavgupta40@gmail.com>
From:   Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Message-ID: <471ffa19-e595-3321-87a9-3b42f024ed66@intel.com>
Date:   Mon, 9 Nov 2020 14:38:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201107100420.149521-1-vaibhavgupta40@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 11/7/20 11:04 AM, Vaibhav Gupta wrote:
> PCI helper functions such as pci_enable/disable_device(),
> pci_save/restore_state(), pci_set_power_state(), etc. were used by the
> legacy framework to perform standard operations related to PCI PM.
> 
> This driver is using the generic framework and thus calls for those
> functions should be dropped as those tasks are now performed by the PCI
> core.
> 
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> ---

Acked-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
