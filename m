Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDD6FA6680
	for <lists+linux-scsi@lfdr.de>; Tue,  3 Sep 2019 12:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfICKZL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 3 Sep 2019 06:25:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:45420 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727005AbfICKZK (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 3 Sep 2019 06:25:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BCC73AD46;
        Tue,  3 Sep 2019 10:25:09 +0000 (UTC)
Message-ID: <1567506309.2878.5.camel@suse.com>
Subject: Re: [PATCH] Revert "gpss: core: no waiters left behind on
 deregister"
From:   Oliver Neukum <oneukum@suse.com>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        stern@rowland.harvard.edu
Date:   Tue, 03 Sep 2019 12:25:09 +0200
In-Reply-To: <20190903101840.16483-2-oneukum@suse.com>
References: <20190903101840.16483-1-oneukum@suse.com>
         <20190903101840.16483-2-oneukum@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Am Dienstag, den 03.09.2019, 12:18 +0200 schrieb Oliver Neukum:
> This reverts commit f95aec18e46af9d7fb6f312020824d536dd720dd.

Please ignore this.

	Regards
		Oliver

