Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED8DAD9E6
	for <lists+linux-scsi@lfdr.de>; Mon,  9 Sep 2019 15:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfIINWW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 9 Sep 2019 09:22:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:27275 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729859AbfIINWW (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 9 Sep 2019 09:22:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2019 06:22:21 -0700
X-IronPort-AV: E=Sophos;i="5.64,484,1559545200"; 
   d="scan'208";a="191510610"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2019 06:22:19 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 9ABB120764; Mon,  9 Sep 2019 16:22:17 +0300 (EEST)
Date:   Mon, 9 Sep 2019 16:22:17 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-scsi@vger.kernel.org, Joe Perches <joe@perches.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 1/1] scsi: lpfc: Convert existing %pf users to %ps
Message-ID: <20190909132217.GD5781@paasikivi.fi.intel.com>
References: <20190904160423.3865-1-sakari.ailus@linux.intel.com>
 <yq1lfuzkg21.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1lfuzkg21.fsf@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, Sep 07, 2019 at 04:27:34PM -0400, Martin K. Petersen wrote:
> 
> Sakari,
> 
> > Convert the remaining %pf users to %ps to prepare for the removal of
> > the old %pf conversion specifier support.
> 
> Applied to 5.4/scsi-queue, thanks!

Thanks, Martin!

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
