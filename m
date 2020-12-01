Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3F02C9A60
	for <lists+linux-scsi@lfdr.de>; Tue,  1 Dec 2020 10:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbgLAI5E (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 1 Dec 2020 03:57:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:57678 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387756AbgLAI5B (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 1 Dec 2020 03:57:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AAF8EACA8;
        Tue,  1 Dec 2020 08:56:19 +0000 (UTC)
Date:   Tue, 1 Dec 2020 09:56:19 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     trix@redhat.com
Cc:     njavali@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, GR-QLogic-Storage-Upstream@marvell.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: qla2xxx: remove trailing semicolon in macro
 definition
Message-ID: <20201201085619.u47puf2tkvbrns3n@beryllium.lan>
References: <20201130205509.3447316-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130205509.3447316-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Nov 30, 2020 at 12:55:09PM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> The macro use will already have a semicolon.
> Remove unneeded escaped newline.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
