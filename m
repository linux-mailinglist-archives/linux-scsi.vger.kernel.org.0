Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5653E2A47EE
	for <lists+linux-scsi@lfdr.de>; Tue,  3 Nov 2020 15:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgKCNqu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 3 Nov 2020 08:46:50 -0500
Received: from netrider.rowland.org ([192.131.102.5]:38737 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729249AbgKCNpY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 3 Nov 2020 08:45:24 -0500
Received: (qmail 1521753 invoked by uid 1000); 3 Nov 2020 08:45:23 -0500
Date:   Tue, 3 Nov 2020 08:45:23 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Luo Jiaxing <luojiaxing@huawei.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        john.garry@huawei.com, himanshu.madhani@cavium.com,
        felipe.balbi@linux.intel.com, uma.shankar@intel.com,
        anshuman.gupta@intel.com, animesh.manna@intel.com,
        linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v3 0/5] Introduce a new helper marco
 DEFINE_SHOW_STORE_ATTRIBUTE at seq_file.c
Message-ID: <20201103134523.GA1521034@rowland.harvard.edu>
References: <1604406584-53926-1-git-send-email-luojiaxing@huawei.com>
 <20201103133644.GA2067567@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103133644.GA2067567@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Nov 03, 2020 at 02:36:44PM +0100, Greg KH wrote:
> On Tue, Nov 03, 2020 at 08:29:39PM +0800, Luo Jiaxing wrote:
> > We already own DEFINE_SHOW_ATTRIBUTE() helper macro for defining attribute
> > for read-only file, but we found many of drivers also want a helper macro
> > for read-write file too.
> > 
> > So we add this macro to help decrease code duplication.
> > 
> > ---
> >  v1->v2:
> >         1.Rename DEFINE_STORE_ATTRIBUTE() to DEFINE_SHOW_STORE_ATTRIBUTE().
> >  v2->v3:
> >         1.Fixed some spelling mistakes in commit.
> >         2.Revised resumes are added for easy tracing.
> 
> You forgot to address Al Viro's review comments :(

You also might want to fix the type in the Subject line ("marco" instead 
of "macro").

Alan Stern
