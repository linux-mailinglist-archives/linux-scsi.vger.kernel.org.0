Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB6C53FA74
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jun 2022 11:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239855AbiFGJz3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 Jun 2022 05:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240538AbiFGJzO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 Jun 2022 05:55:14 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4003DD02BD
        for <linux-scsi@vger.kernel.org>; Tue,  7 Jun 2022 02:55:13 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id y17so13837116ilj.11
        for <linux-scsi@vger.kernel.org>; Tue, 07 Jun 2022 02:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EhetO9sGvPkHo3mcX48TWi02KhcJRZHv+n1ZFdy7aWk=;
        b=eDIb1BpT1WJ3hS7mj7R6nxDZL8OjVfxdo3Xo+viVQiGRANrDwDV71PwlSddtA692JG
         lpGgsOB3DXX/jEEDfo2u86GyyQZDtVb72WmtDLrfkF1dJgIt3epPjf0cKDjsg6NEc6il
         eBnKCu4VnazvrE+WmU9b7VJhSCQn/vDMGurlpASoyyOQS1pOpbieAi9WyEQro3quk3st
         X334UA7SFUKKBRpo0oftaBO9hOlxP0qtbkGbGp14pYyO+VkMcedE6bQzRpUDWcVmx1/N
         GlbQWtYvh9ooC5bmzxgHrtAMFnKBni76YcR22mKFSa0q/DxYXgQigZ7kW6Gj6eyNeh2t
         YVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=EhetO9sGvPkHo3mcX48TWi02KhcJRZHv+n1ZFdy7aWk=;
        b=a+fMSujrQwmHqDRH2WD2gXXWi+TtB9bLt7H1MTdATfPRydq8JwDNEDbl+fY51rpHts
         hygsNbfHDCJ9kjKmRHD2/OINj+LWb+yIpOwkKg/TASKVg8PAt+dVwMcEc4SGFGTEGooK
         /0mqm+7NWRRTi9R/Wo8A3vr6wY8I/QQdgGAS0chZwc0M0W5NxdAn9za1+c0UxoQf+8pw
         cFWPl7o9qoOWK2TdxwcQWWPoztAvme01ZF//ORIyXQtIQrCPYvQrxMbnPChf0fH+vb4D
         S4Zl81exkU/z5ZDGQOWbEw55WwJBFade3JfN9MgZJ8QvADhYg1s1mwKzYZ0ByJFqr8e8
         vehQ==
X-Gm-Message-State: AOAM533cD85XDyEWefBnP8vDl2mYwQ/uzS35qBAnneznwRP4xIr/AcbK
        Qy/hQQN3riWQSk3oTKgOJJBcLyp8G+yQG0vZwxU=
X-Google-Smtp-Source: ABdhPJxlW1D2MMqL1fjXPX3SPS4qjFU+j10igeGWseJ7VgFoL3Z1d3vhMUjjLTYVoM3e5zK1O1QZHYZKomUuwQgfFPs=
X-Received: by 2002:a05:6e02:2186:b0:2d1:b538:f5e3 with SMTP id
 j6-20020a056e02218600b002d1b538f5e3mr17015952ila.22.1654595712632; Tue, 07
 Jun 2022 02:55:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:b916:0:0:0:0:0 with HTTP; Tue, 7 Jun 2022 02:55:11 -0700 (PDT)
Reply-To: euromillionsawardwinning@yahoo.com
From:   EuroMillions <favourify439@gmail.com>
Date:   Tue, 7 Jun 2022 02:55:11 -0700
Message-ID: <CAKVkz5dSYdwiw_tNLE=Nr1qGZDZ+JpLPvY5R=2kSbd7zQjDpng@mail.gmail.com>
Subject: Re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fabelhaft, Sie haben =E2=82=AC650.000,00  pro Monat gewonnen
EuroMillions/GooglePromo-Gewinnspiele am 7. Juni 2022.

Bitte senden Sie uns die folgenden Informationen, um Ihren Preis
(Geld) zu erhalten.
1.) Vollst=C3=A4ndiger Name:
2.) Postanschrift:
3.) Telefonnummern:
4.) Beruf:
5.) Geburtsdatum:
6.) Geschlecht:

Herr Johannes Holz
Online-Koordinator
