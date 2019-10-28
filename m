Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF13EE6EA5
	for <lists+linux-scsi@lfdr.de>; Mon, 28 Oct 2019 10:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387552AbfJ1JDj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 28 Oct 2019 05:03:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:50500 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730849AbfJ1JDj (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 28 Oct 2019 05:03:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11EA8B04F;
        Mon, 28 Oct 2019 09:03:38 +0000 (UTC)
Date:   Mon, 28 Oct 2019 10:03:37 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <hmadhani@marvell.com>
Subject: Re: [PATCH] scsi: qla2xxx: Check return value of alloc_workqueue()
Message-ID: <20191028090337.i2n25yeuxw3rvacn@beryllium>
References: <20191028084709.81538-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028084709.81538-1-dwagner@suse.de>
User-Agent: NeoMutt/20180716
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Oct 28, 2019 at 09:47:09AM +0100, Daniel Wagner wrote:
> Do not derefence the pointer without checking it
> first. alloc_workqueue() can return a NULL pointer.

Oh forget it. Someone was faster :)
