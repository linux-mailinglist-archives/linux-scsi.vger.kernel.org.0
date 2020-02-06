Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA0D154356
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Feb 2020 12:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgBFLo1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Feb 2020 06:44:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:56342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgBFLo1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 6 Feb 2020 06:44:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 89D63ACE3
        for <linux-scsi@vger.kernel.org>; Thu,  6 Feb 2020 11:44:26 +0000 (UTC)
Message-ID: <1580989463.21862.11.camel@suse.com>
Subject: return value queuecommand should return after an unplug
From:   Oliver Neukum <oneukum@suse.com>
To:     linux-scsi@vger.kernel.org
Date:   Thu, 06 Feb 2020 12:44:23 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

I am looking at the queuecommand() mathod of the UAS low
level driver. What is a host adaptor driver to do when
it gets a scsi request for an unplugged host adapter?

All teh return values I see say that something is busy.
But I have the case that something is dead and gone.

	Regards
		Oliver

