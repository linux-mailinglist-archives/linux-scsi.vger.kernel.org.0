Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773387807C1
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Aug 2023 11:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjHRJCW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 18 Aug 2023 05:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358902AbjHRJBz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 18 Aug 2023 05:01:55 -0400
X-Greylist: delayed 1505 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Aug 2023 02:01:32 PDT
Received: from mail.leachkin.pl (mail.leachkin.pl [217.61.97.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A65422E
        for <linux-scsi@vger.kernel.org>; Fri, 18 Aug 2023 02:01:32 -0700 (PDT)
Received: by mail.leachkin.pl (Postfix, from userid 1001)
        id 5F19F84103; Fri, 18 Aug 2023 09:16:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leachkin.pl; s=mail;
        t=1692346573; bh=elHzctRz/z3PfTIhGYJKd0TeBTmca98Y+JNgX4gfsPI=;
        h=Date:From:To:Subject:From;
        b=af/cIJrcuKTu9BgzmdbZSRnDVvMjd1Zdfy0606nhLBhfbzFJ2B3iwt5esBMNBFwFQ
         aodF035ALBci0LEqlMDHw404SSZfCPUMGWeg6iSRhHywsqNBOU+niO927XreTKgCzg
         0Z0LuwzNrA4UDhFB3uSVgQYhbx6FXGt+PHvEHqtpepUXiehzFBDlPc7o5ELt5aEDuw
         G5jM04XEPLCPuvpQ1MmIL/zz/IS+qFKe6wM8X/k/7DTaIBcMWiXDng8KVM2lLfQLcP
         xTroj4Cg1ZAiPrub2z8BWTzYtj0WLoO3HujBuOmT6pYFqETd73cQhTgcVRH2dAjQ4L
         rUNs46Th7wX3g==
Received: by mail.leachkin.pl for <linux-scsi@vger.kernel.org>; Fri, 18 Aug 2023 08:15:51 GMT
Message-ID: <20230818074501-0.1.4u.ctxf.0.5bnzh6qxop@leachkin.pl>
Date:   Fri, 18 Aug 2023 08:15:51 GMT
From:   "Jakub Lemczak" <jakub.lemczak@leachkin.pl>
To:     <linux-scsi@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.leachkin.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam,
Jakub Lemczak
