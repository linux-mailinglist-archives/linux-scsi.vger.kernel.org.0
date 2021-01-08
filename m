Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8B42EEF36
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Jan 2021 10:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbhAHJMb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 8 Jan 2021 04:12:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:43486 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbhAHJMb (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 8 Jan 2021 04:12:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 50B1BACC6;
        Fri,  8 Jan 2021 09:11:50 +0000 (UTC)
Date:   Fri, 8 Jan 2021 10:11:49 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     James Smart <jsmart2021@gmail.com>
Cc:     linux-scsi@vger.kernel.org, Ram Vegesna <ram.vegesna@broadcom.com>
Subject: Re: [PATCH v7 20/31] elx: efct: RQ buffer, memory pool allocation
 and deallocation APIs
Message-ID: <20210108091149.v7ts7xdweub5mrlw@beryllium.lan>
References: <20210107225905.18186-1-jsmart2021@gmail.com>
 <20210107225905.18186-21-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107225905.18186-21-jsmart2021@gmail.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Jan 07, 2021 at 02:58:54PM -0800, James Smart wrote:
> This patch continues the efct driver population.
> 
> This patch adds driver definitions for:
> RQ data buffer allocation and deallocate.
> Memory pool allocation and deallocation APIs.
> Mailbox command submission and completion routines.
> 
> Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

