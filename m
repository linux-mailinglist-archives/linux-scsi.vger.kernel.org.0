Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9D04FADB6
	for <lists+linux-scsi@lfdr.de>; Sun, 10 Apr 2022 13:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbiDJL5s (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 10 Apr 2022 07:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238644AbiDJL5q (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 10 Apr 2022 07:57:46 -0400
Received: from guaco.floridaarsonseminar.com (guaco.floridaarsonseminar.com [85.202.169.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A8D3AA4F
        for <linux-scsi@vger.kernel.org>; Sun, 10 Apr 2022 04:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim; d=floridaarsonseminar.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding; i=rae.leo@floridaarsonseminar.com;
 bh=MnUf62F7Cn+TYukvIUFpyVBy5Yk=;
 b=aT8GyMWxPD3J5ulxmUaBrdpQITmHrHlErL93td6b+V2MSRAldQb/H2n3g20PJXk0MeZytQNgESKj
   YZIOpXclBiNA6Wh40M4PbEb8i/G3SFCRVXG8PYECQM0pGyGOPZLpOOSG0866Dgc2G1bAl8AtJiuA
   EK3C1Kgcv8F0Flc6tyrR0SJ2kBLTYR73a4foVs6n7I4au2n91zILlznIzyuYwo0ajc0Xv0fBtFUf
   xVykAoQoZYTJIdkAKlhe2bZpf9PoLAxPZp07VJGwGdfKuPtp25hRYdWZmlvrWY4KaZGUzMs/2/oO
   wAtPs46GrXRCEswbAkx3dyjsQsU0GtJ558uZGg==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=floridaarsonseminar.com;
 b=HeQN5UD83709VCEpzWQaSujToRmvIuGLHh3JQHwiNfGBLGVJg7aWWJlH/06vGxP7r+x3yH7SsZ8M
   6NlPn2b3f7J+F1x2DAn6/Rxs8HqNKQDMv76Kfhcr5Rhcnyi59kvyT9bD4XTfrrCxJgTWj6fmhNXD
   /c3B23x/kidmnVPyEbJI5d+kFljUmqA/c4KWc793h4h3W1C7j9uAWIMZoKmMrPCI1/tXQwxZkDYq
   IRyGCMmroYzvgN8x1aaBl4byxZH640XnJSE7CNaN2DWf2/tbrEJC9XOzU5EDKZ1C2CLOT8+fsDRA
   w0FBJSNyeE9x6I/3vjbYgRqofYHiqjylKBLBYg==;
Reply-To: ayvamustafa22@gmail.com
From:   rae.leo@floridaarsonseminar.com
To:     linux-scsi@vger.kernel.org
Subject: Hello
Date:   10 Apr 2022 13:55:21 +0200
Message-ID: <20220410135521.7E58BD6D475C1073@floridaarsonseminar.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L3,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.9 RCVD_IN_MSPIKE_L3 RBL: Low reputation (-3)
        *      [85.202.169.206 listed in bl.mailspike.net]
        *  1.3 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in
        *      bl.spamcop.net
        *      [Blocked - see <https://www.spamcop.net/bl.shtml?85.202.169.206>]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [ayvamustafa22[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 RCVD_IN_MSPIKE_BL Mailspike blacklisted
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

sauda=C3=A7=C3=B5es ,

Estou procurando um parente do meu falecido cliente Sr. Robert,=20
que perdeu a vida devido =C3=A0 doen=C3=A7a do Coronav=C3=ADrus, que ele=20=

contraiu durante sua viagem de neg=C3=B3cios na China. Eu sou seu=20
advogado pessoal e estou procurando seus parentes mais pr=C3=B3ximos,=20
entrei em contato com voc=C3=AA para trabalhar comigo na garantia da=20
transfer=C3=AAncia de um fundo fiduci=C3=A1rio, quatro milh=C3=B5es,=20
quatrocentos e vinte mil d=C3=B3lares, legado por meu falecido=20
cliente.

Entre em contato comigo imediatamente para obter mais=20
informa=C3=A7=C3=B5es.

esperando
Mustaf=C3=A1 Aivaz
